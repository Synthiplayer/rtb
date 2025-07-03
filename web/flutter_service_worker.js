'use strict';

const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

// Wird durch das Flutter-Build automatisch ersetzt:
const RESOURCES = {
  // "main.dart.js": "xyz123...", ...
  // Alle statischen Assets
};

const CORE = [
  "main.dart.js",
  "index.html",
  "flutter_bootstrap.js",
  "assets/AssetManifest.bin.json",
  "assets/FontManifest.json"
];

// Install: App-Shell im TEMP Cache vorladen
self.addEventListener("install", (event) => {
  self.skipWaiting();
  event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(CORE.map((value) => new Request(value, { cache: 'reload' })));
    })
  );
});

// Activate: Temp Cache zu dauerhaftem Cache machen, veraltete Files löschen
self.addEventListener("activate", (event) => {
  event.waitUntil(async function() {
    try {
      const contentCache = await caches.open(CACHE_NAME);
      const tempCache = await caches.open(TEMP);
      const manifestCache = await caches.open(MANIFEST);
      const manifest = await manifestCache.match('manifest');

      // Erstinstallation: Alles aus TEMP übernehmen
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        for (const request of await tempCache.keys()) {
          const response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        self.clients.claim();
        return;
      }

      // Upgrade: nur noch gültige Ressourcen behalten
      const oldManifest = await manifest.json();
      const origin = self.location.origin;

      for (const request of await contentCache.keys()) {
        let key = request.url.startsWith(origin) ? request.url.substring(origin.length + 1) : request.url;
        if (key === '' || key === '/') key = '/';
        if (!RESOURCES[key] || RESOURCES[key] !== oldManifest[key]) {
          await contentCache.delete(request);
        }
      }

      // Neue Dateien hinzufügen
      for (const request of await tempCache.keys()) {
        const response = await tempCache.match(request);
        await contentCache.put(request, response);
      }

      await caches.delete(TEMP);
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      self.clients.claim();

    } catch (err) {
      // Bei Upgrade-Fehlern: Alles neu!
      console.error('Failed to upgrade service worker:', err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// Fetch-Handler:
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') return;

  const url = new URL(event.request.url);
  const origin = self.location.origin;
  let key = url.pathname.substring(1);

  // Hash-Parameter entfernen
  if (key.indexOf('?v=') !== -1) key = key.split('?v=')[0];
  if (event.request.url === origin || event.request.url.startsWith(origin + '/#') || key === '') key = '/';

  // Sonderbehandlung: tourdaten.json network-first mit Benachrichtigung
  if (url.pathname.endsWith('/tour/tourdaten.json')) {
    event.respondWith(
      fetch(event.request)
        .then(networkResponse => {
          networkResponse.clone().json().then((jsonData) => {
            caches.open(CACHE_NAME).then(cache => {
              cache.match(event.request).then(cached => {
                if (cached) {
                  cached.json().then(oldJson => {
                    if (JSON.stringify(oldJson) !== JSON.stringify(jsonData)) {
                      self.clients.matchAll().then(clients => {
                        clients.forEach(client => {
                          client.postMessage({ type: 'TOUR_DATA_UPDATED' });
                        });
                      });
                    }
                  });
                }
                cache.put(event.request, networkResponse.clone());
              });
            });
          });
          return networkResponse;
        })
        .catch(() => caches.open(CACHE_NAME).then(cache => cache.match(event.request)))
    );
    return;
  }

  // SPA-Navigation: Fallback auf index.html
  if (event.request.mode === 'navigate') {
    event.respondWith(
      caches.open(CACHE_NAME).then(cache => cache.match('index.html'))
    );
    return;
  }

  // Nur Ressourcen cachen, die bekannt sind
  if (!RESOURCES[key]) return;

  // Online-First für App-Shell, Cache-First für alles andere
  if (key === '/') {
    return onlineFirst(event);
  }

  event.respondWith(
    caches.open(CACHE_NAME)
      .then(cache => cache.match(event.request)
        .then(response =>
          response || fetch(event.request).then(resp => {
            if (resp && resp.ok) cache.put(event.request, resp.clone());
            return resp;
          })
        )
      )
  );
});

// Message-Handler: skipWaiting, DownloadOffline etc.
self.addEventListener('message', (event) => {
  if (event.data === 'skipWaiting') self.skipWaiting();
  if (event.data === 'downloadOffline') downloadOffline();
});

async function downloadOffline() {
  const resources = [];
  const contentCache = await caches.open(CACHE_NAME);
  const origin = self.location.origin;
  const currentContent = {};
  for (const request of await contentCache.keys()) {
    let key = request.url.startsWith(origin) ? request.url.substring(origin.length + 1) : request.url;
    if (key === '' || key === '/') key = '/';
    currentContent[key] = true;
  }
  for (const resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) resources.push(resourceKey);
  }
  return contentCache.addAll(resources);
}

// Online-first für die App-Shell
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request)
      .then(response => {
        return caches.open(CACHE_NAME).then(cache => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
      .catch(error => {
        return caches.open(CACHE_NAME)
          .then(cache => cache.match(event.request)
            .then(resp => {
              if (resp) return resp;
              throw error;
            })
          );
      })
  );
}
