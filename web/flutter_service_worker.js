'use strict';
const MANIFEST    = 'flutter-app-manifest';
const TEMP        = 'flutter-temp-cache';
const CACHE_NAME  = 'flutter-app-cache';

const RESOURCES = {
  // ... (alle Ressourcen wie im Original; hier gekürzt) ...
  "tour/tourdaten.json": "UNWICHTIGER_HASH_ODER_LEER",
  // ...
};

// Die Application-Shell wie gehabt...
const CORE = [
  "main.dart.js",
  "index.html",
  "flutter_bootstrap.js",
  "assets/AssetManifest.bin.json",
  "assets/FontManifest.json"
];

// Install-Handler
self.addEventListener("install", (event) => {
  self.skipWaiting();
  event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, { 'cache': 'reload' }))
      );
    })
  );
});

// Activate-Handler
self.addEventListener("activate", (event) => {
  event.waitUntil(async function() {
    try {
      var contentCache  = await caches.open(CACHE_NAME);
      var tempCache     = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest      = await manifestCache.match('manifest');

      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        self.clients.claim();
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;

      // Alte Ressourcen entfernen
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key === '') key = '/';
        if (!RESOURCES[key] || RESOURCES[key] !== oldManifest[key]) {
          await contentCache.delete(request);
        }
      }

      // Neue aus TEMP hinzufügen
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      self.clients.claim();

    } catch (err) {
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// Fetch-Handler
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') return;

  // Sonderfall: Network-first für tourdaten.json mit Change-Notification
  if (
    event.request.url.endsWith('/tourdaten.json') ||
    event.request.url.includes('/tour/tourdaten.json')
  ) {
    event.respondWith(
      fetch(event.request)
        .then((networkResponse) => {
          // 1. Neue Daten aus JSON parsen
          networkResponse.clone().json().then((jsonData) => {
            // 2. Alte Version aus Cache holen
            caches.open(CACHE_NAME).then((cache) => {
              cache.match(event.request).then((cachedResp) => {
                if (cachedResp) {
                  cachedResp.json().then((oldJson) => {
                    // 3. Vergleich
                    if (JSON.stringify(oldJson) !== JSON.stringify(jsonData)) {
                      // 4. Benachrichtigung an alle Clients
                      self.clients.matchAll().then((clients) => {
                        clients.forEach((client) => {
                          client.postMessage({ type: 'TOUR_DATA_UPDATED' });
                        });
                      });
                    }
                  });
                }
                // 5. Cache aktualisieren
                cache.put(event.request, networkResponse.clone());
              });
            });
          });
          // 6. Ursprüngliche Netz-Antwort zurückgeben
          return networkResponse;
        })
        .catch(() => {
          // Offline-Fallback
          return caches.open(CACHE_NAME)
            .then((cache) => cache.match(event.request));
        })
    );
    return;
  }

  // Standard Flutter-Cache-First-Strategie
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  if (key.indexOf('?v=') !== -1) {
    key = key.split('?v=')[0];
  }
  if (
    event.request.url === origin ||
    event.request.url.startsWith(origin + '/#') ||
    key === ''
  ) {
    key = '/';
  }
  if (!RESOURCES[key]) return;
  if (key === '/') {
    return onlineFirst(event);
  }

  event.respondWith(
    caches.open(CACHE_NAME)
      .then((cache) => cache.match(event.request)
        .then((response) => {
          return response || fetch(event.request).then((resp) => {
            if (resp && resp.ok) cache.put(event.request, resp.clone());
            return resp;
          });
        })
      )
  );
});

// Message-Handler
self.addEventListener('message', (event) => {
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
  }
});

// Offline-Download
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  var origin = self.location.origin;

  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key === '') key = '/';
    currentContent[key] = true;
  }

  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) resources.push(resourceKey);
  }
  return contentCache.addAll(resources);
}

// Online-first-Strategie für '/'
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request)
      .then((response) => {
        return caches.open(CACHE_NAME)
          .then((cache) => {
            cache.put(event.request, response.clone());
            return response;
          });
      })
      .catch((error) => {
        return caches.open(CACHE_NAME)
          .then((cache) => cache.match(event.request)
            .then((resp) => {
              if (resp) return resp;
              throw error;
            })
          );
      })
  );
}
