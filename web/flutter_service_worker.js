'use strict';

const MANIFEST   = 'flutter-app-manifest';
const TEMP       = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

// Vom Flutter-Build automatisch befüllt:
const RESOURCES = {"app-icons/maskable_icon_x192.png": "c00ef033b045e2071255d60f41b7ac3e",
"app-icons/maskable_icon_x512.png": "cfb191545065c8c99352d5460996db67",
"assets/AssetManifest.bin": "308f7cbf755586e311f7713bdb57ec34",
"assets/AssetManifest.bin.json": "5c1438cb98cff53f797d5a70b4643bc1",
"assets/AssetManifest.json": "13754743f57d05e800c422d866330433",
"assets/assets/fonts/AIRSTREA.ttf": "fb6a0f1836f718ee6723bceb8f117bb2",
"assets/assets/fonts/NunitoSans-Italic-VariableFont_YTLC,opsz,wdth,wght.ttf": "e74a88245267f5b89a0f3db34da70d0c",
"assets/assets/fonts/NunitoSans-VariableFont_YTLC,opsz,wdth,wght.ttf": "303dbed3d72cb16b3276faba4b463477",
"assets/assets/images/gallery/bild_1.webp": "5bc47708f3986feae2d94b016b2a8dc1",
"assets/assets/images/gallery/bild_10.webp": "bf025b1c3c084ed611ace6a2de46415c",
"assets/assets/images/gallery/bild_2.webp": "93e2c28e893e284cd27c1eaca50dde42",
"assets/assets/images/gallery/bild_3.webp": "a1c7f4c266f181db904e5bf436ecff65",
"assets/assets/images/gallery/bild_4.webp": "c5307cf96224da4e9c05bc09f80a6406",
"assets/assets/images/gallery/bild_5.webp": "8d87119fc10daee42a8a8451dc47be59",
"assets/assets/images/gallery/bild_6.webp": "bbb89c111b441373c9031e00ec323388",
"assets/assets/images/gallery/bild_7.webp": "c89026e05dd79d63cee9e1168a5bc574",
"assets/assets/images/gallery/bild_8.webp": "e2d8093a8726d46ee6c6351faf085a2f",
"assets/assets/images/gallery/bild_9.webp": "1f2cc0563747da77f0874566112e7252",
"assets/assets/images/hero.webp": "0d45066262e065d85605939dcd78c8ef",
"assets/assets/images/hero2.webp": "bbb89c111b441373c9031e00ec323388",
"assets/assets/images/hero3.webp": "5bc47708f3986feae2d94b016b2a8dc1",
"assets/assets/images/mediabild_retro_v2.webp": "eae5c358b8df2a59893be0ab6874f41f",
"assets/assets/images/members/bjoern.webp": "2551b1ce5a71f4558d3a8341beacac99",
"assets/assets/images/members/danny.webp": "4066f067a6ab7f5d6f0d679d38271b5e",
"assets/assets/images/members/joern.webp": "8ce59407d45dda9291abae8f0344e99d",
"assets/assets/images/members/ragtag_birds.webp": "b2f38e1a5e15fcb90cb57e09fa843264",
"assets/assets/images/members/sebastian.webp": "018ec8ae3a271b461e68c6fe00a05032",
"assets/assets/images/members/stefan.webp": "72fd5b10edf2c7d4c33a27f282850101",
"assets/assets/images/sharepic_bg_v3.png": "0d203fdbe58f6fe0dac27f02e9493c24",
"assets/FontManifest.json": "81d1ef098963001c092dc442aed5ca67",
"assets/fonts/MaterialIcons-Regular.otf": "1037e8a2b3c9d38fb5540fc8d9325a30",
"assets/NOTICES": "454d0d508e160e46e857877b98c42fbc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_js/assets/js/fetch.js": "277e0c5ec36810cbe57371a4b7e26be0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4668c96bb1d9b183cf7d1a18d14a173a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.ico": "a0be33a96d43a9eecceaeaf5411f0094",
"favicon.png": "00e1bb624915171e2cd31276ae9a6df6",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "a7ff21bcb7f1026f43421a84ffd326f7",
"index.html": "db15b88138320c07a49a680f3fe6c412",
"/": "db15b88138320c07a49a680f3fe6c412",
"main.dart.js": "268a7c21ef71e6f047b33dbfd348f094",
"manifest.json": "8a73e1789c6cd3550dfa48d7e0ce497a",
"news/news.json": "7223e161d10cb7462b39a74e3329b6d5",
"tour/readme.txt": "1eb488945f1f2f6831a3df51665eb762",
"tour/tour.json": "2e653e377c2301069aad7a055cd2125a",
"version.json": "1772f7c5437ed0c85f73ffdfc7950b0a"};

const CORE = [
  "main.dart.js",
  "index.html",
  "flutter_bootstrap.js",
  "assets/AssetManifest.bin.json",
  "assets/FontManifest.json"
];

// INSTALL: App-Shell in TEMP cachen
self.addEventListener('install', event => {
  self.skipWaiting();
  event.waitUntil(
    caches.open(TEMP)
      .then(cache => cache.addAll(
        CORE.map(r => new Request(r, { cache: 'reload' }))
      ))
  );
});

// ACTIVATE: TEMP → CONTENT, alte Dateien löschen
self.addEventListener('activate', event => {
  event.waitUntil((async () => {
    const contentCache  = await caches.open(CACHE_NAME);
    const tempCache     = await caches.open(TEMP);
    const manifestCache = await caches.open(MANIFEST);
    const manifest      = await manifestCache.match('manifest');

    // Erstinstallation
    if (!manifest) {
      await caches.delete(CACHE_NAME);
      for (const req of await tempCache.keys()) {
        const res = await tempCache.match(req);
        await contentCache.put(req, res);
      }
      await caches.delete(TEMP);
      await manifestCache.put(
        'manifest',
        new Response(JSON.stringify(RESOURCES))
      );
      self.clients.claim();
      return;
    }

    // Upgrade: entferne geänderte/gelöschte Assets
    const oldManifest = await manifest.json();
    const origin      = self.location.origin;
    for (const req of await contentCache.keys()) {
      let key = req.url.startsWith(origin)
        ? req.url.substring(origin.length + 1)
        : req.url;
      if (key === '' || key === '/') key = '/';
      if (!RESOURCES[key] || RESOURCES[key] !== oldManifest[key]) {
        await contentCache.delete(req);
      }
    }

    // TEMP → CONTENT
    for (const req of await tempCache.keys()) {
      const res = await tempCache.match(req);
      await contentCache.put(req, res);
    }

    await caches.delete(TEMP);
    await manifestCache.put(
      'manifest',
      new Response(JSON.stringify(RESOURCES))
    );
    self.clients.claim();
  })());
});

// FETCH: network- bzw. cache-Strategien
self.addEventListener('fetch', event => {
  if (event.request.method !== 'GET') return;

  const url = new URL(event.request.url);

  // Nur Anfragen mit http/https-Schema bearbeiten und cachen.
  if (!url.protocol.startsWith('http')) {
    return;
  }

  // 1) Tour-JSON: network-first, dann Cache
  if (url.pathname.endsWith('/tour/tour.json')) {
    event.respondWith(networkFirst(event.request));
    return;
  }

  // 2) News-JSON: network-first, dann Cache
  if (url.pathname.endsWith('/news/news.json')) {
    event.respondWith(networkFirst(event.request));
    return;
  }

  // 3) SPA-Navigation (index.html): nur für „echte“ Seiten ohne Dateiendung
if (event.request.mode === 'navigate') {
  const path = url.pathname;

  // a) Lass ALLES unter /epk/ ungefiltert zum Netzwerk durch (damit Downloads funktionieren)
  if (path.startsWith('/epk/')) {
    return; // Browser lädt normal vom Server
  }

  // b) Wenn die URL wie eine Datei aussieht (z. B. .zip, .txt, .pdf), KEIN SPA-Fallback
  if (/\.[^/]+$/.test(path)) {
    return; // normale Netz-Anfrage
  }

  // c) „Normale“ App-Routen -> SPA-Shell
  event.respondWith(cacheFirst('/index.html'));
  return;
}


  // 4) Statische RESOURCES: cache-first
  const key = url.pathname.substring(1);
  if (RESOURCES[key]) {
    event.respondWith(cacheFirst(url.pathname));
    return;
  }

  // 5) Alle anderen: network-first, dann Cache
  event.respondWith(networkFirst(event.request));
});

// Helfer: network-first mit Cache-Fallback
async function networkFirst(request) {
  const cache = await caches.open(CACHE_NAME);
  try {
    const response = await fetch(request);
    if (response && response.ok) {
      cache.put(request, response.clone());
    }
    return response;
  } catch (e) {
    const cached = await cache.match(request);
    if (cached) return cached;
    return new Response('Service Unavailable', { status: 504 });
  }
}

// Helfer: cache-first mit Netzwerk-Fallback
function cacheFirst(path) {
  return caches.open(CACHE_NAME).then(cache =>
    cache.match(path).then(cached => {
      if (cached) return cached;
      return fetch(path).then(resp => {
        if (resp && resp.ok) cache.put(path, resp.clone());
        return resp;
      });
    })
  );
}

// Message-Handler
self.addEventListener('message', event => {
  if (event.data === 'skipWaiting')     self.skipWaiting();
  if (event.data === 'downloadOffline') downloadOffline();
});

// DownloadOffline: alle RESOURCES cachen
async function downloadOffline() {
  const cache = await caches.open(CACHE_NAME);
  const keys  = await cache.keys();
  const current = {};
  for (const req of keys) {
    const u = new URL(req.url);
    const k = u.pathname.substring(1) || '/';
    current[k] = true;
  }
  const toCache = Object.keys(RESOURCES).filter(k => !current[k]);
  return cache.addAll(toCache);
}
