// custom_service_worker.js

const CACHE_NAME = 'app-cache-v1';
const TOURDATA_URL = '/tourdaten.json';

self.addEventListener('install', (event) => {
  // Hier kann man Grund-Assets cachen, wenn gewünscht
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  // Alte Caches aufräumen, wenn nötig
  event.waitUntil(
    caches.keys().then(keys => Promise.all(
      keys.filter(key => key !== CACHE_NAME).map(key => caches.delete(key))
    ))
  );
  self.clients.claim();
});

// STALE-WHILE-REVALIDATE für tourdaten.json
self.addEventListener('fetch', (event) => {
  const url = new URL(event.request.url);
  // Flutter-Assets cache-first (optional, für offline-App):
  if (url.pathname.startsWith('/assets/') || url.pathname.endsWith('.js') || url.pathname.endsWith('.css')) {
    event.respondWith(
      caches.open(CACHE_NAME).then(cache =>
        cache.match(event.request).then(response =>
          response || fetch(event.request).then(networkResponse => {
            cache.put(event.request, networkResponse.clone());
            return networkResponse;
          })
        )
      )
    );
    return;
  }

  // Speziell für tourdaten.json: stale-while-revalidate
  if (url.pathname === TOURDATA_URL) {
    event.respondWith(
      caches.open(CACHE_NAME).then(cache =>
        cache.match(event.request).then(cachedResponse => {
          const fetchPromise = fetch(event.request).then(networkResponse => {
            cache.put(event.request, networkResponse.clone());
            return networkResponse;
          }).catch(() => {});
          return cachedResponse || fetchPromise;
        })
      )
    );
    return;
  }
  // Default: normal weiterleiten
  // Oder: hier alles offline-cachen was du willst
});
