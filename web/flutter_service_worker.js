'use strict';

const MANIFEST   = 'flutter-app-manifest';
const TEMP       = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

// Vom Flutter-Build automatisch befüllt:
const RESOURCES = {"app-icons/maskable_icon_x192.png": "c00ef033b045e2071255d60f41b7ac3e",
"app-icons/maskable_icon_x512.png": "cfb191545065c8c99352d5460996db67",
"assets/AssetManifest.bin": "d6422f1b3a4b9003b42b72c1484aa26a",
"assets/AssetManifest.bin.json": "db8c357f8cf789cc8fa640408196eb11",
"assets/AssetManifest.json": "58ef75b4244d1ce112d9e24d07010595",
"assets/assets/fonts/AIRSTREA.ttf": "fb6a0f1836f718ee6723bceb8f117bb2",
"assets/assets/fonts/NunitoSans-Italic-VariableFont_YTLC,opsz,wdth,wght.ttf": "e74a88245267f5b89a0f3db34da70d0c",
"assets/assets/fonts/NunitoSans-VariableFont_YTLC,opsz,wdth,wght.ttf": "303dbed3d72cb16b3276faba4b463477",
"assets/assets/images/gallery/bild_1.jpeg": "df3f41a8ff12fda4f3e92a33b8c7f591",
"assets/assets/images/gallery/bild_10.jpeg": "b9c7fd507b1ca3eeaf0a73c649d260ca",
"assets/assets/images/gallery/bild_2.jpeg": "ae965ea01571004f7a98a881bf73949a",
"assets/assets/images/gallery/bild_3.jpeg": "cbf42832a7d5f3a2d31d65c9dfc6d659",
"assets/assets/images/gallery/bild_4.jpeg": "3f87d18d9b52f9a783601e08bf1b1b5a",
"assets/assets/images/gallery/bild_5.jpeg": "702d826af37c007041bf527c2380a71e",
"assets/assets/images/gallery/bild_6.jpeg": "5292a235547e5ac4ef2e58e76e4f9757",
"assets/assets/images/gallery/bild_7.jpeg": "c5042e5f6775c2bfcb1d5b303b43b6b6",
"assets/assets/images/gallery/bild_8.jpeg": "c5c43a8993b1ee089abe7d6e5e75ee18",
"assets/assets/images/gallery/bild_9.jpeg": "17c13499644e9b453e929efaa7ff262f",
"assets/assets/images/hero.jpeg": "cfdc05131ee72a546cafb485b6f11a55",
"assets/assets/images/hero2.jpeg": "5292a235547e5ac4ef2e58e76e4f9757",
"assets/assets/images/hero3.jpeg": "df3f41a8ff12fda4f3e92a33b8c7f591",
"assets/assets/images/logo.png": "ef00f98f0a242a43a4a34ed49ca8af6a",
"assets/assets/images/mediabild.png": "f0ec07c60c00b1238d9746b0feae28d6",
"assets/assets/images/members/bjoern.jpg": "2342dab6383ff73a9510bba02f76f28c",
"assets/assets/images/members/danny.jpg": "f3ddbfb5c689a6d72a0978d6f6c63f95",
"assets/assets/images/members/joern.jpg": "d5b9fadc15f93d0a348daf8e62e8cf0f",
"assets/assets/images/members/ragtag_birds.jpg": "34575b9098bbc1ce37a1be45be9fb3e2",
"assets/assets/images/members/sebastian.jpg": "5e284c6fb1feeb43589547b7efc694bc",
"assets/assets/images/members/stefan.jpg": "72a24fd9508911864e889d5b4933a732",
"assets/assets/images/sharepic_bg_v3.png": "0d203fdbe58f6fe0dac27f02e9493c24",
"assets/FontManifest.json": "81d1ef098963001c092dc442aed5ca67",
"assets/fonts/MaterialIcons-Regular.otf": "8f0d5e7e8a0e7f4447716ded3931a41c",
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
"flutter_bootstrap.js": "1c8c4bac9628b754e8afc4d15b7f02c5",
"index.html": "2b13dbddeb0d8522a03f944b1601bcc1",
"/": "2b13dbddeb0d8522a03f944b1601bcc1",
"main.dart.js": "fc9575e37366c3a97852f6a06298c91a",
"manifest.json": "8a73e1789c6cd3550dfa48d7e0ce497a",
"news/news.json": "7223e161d10cb7462b39a74e3329b6d5",
"tour/readme.txt": "cfc17a5ebe0e1246c916cc86623c81bb",
"tour/tour.json": "254d7bd069663b104a59e092790c7d7f",
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

  // 3) SPA-Navigation (index.html): cache-first
  if (event.request.mode === 'navigate') {
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
