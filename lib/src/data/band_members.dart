// lib/src/data/band_members.dart
//
// Liste aller Bandmitglieder.
// Hinweis: Für jede Person muss das Bild unter assets/images/members/<name>.jpg
// vorhanden sein und in pubspec.yaml gelistet werden.

import 'package:rtb/src/models/band_member.dart';

/// `final` reicht hier völlig – Compile‑Time‑Konstanz ist nicht notwendig,
/// weil es nur fünf Objekte sind und wir sie nicht als Keys in `const` Widgets
/// verwenden.
final bandMembers = <BandMember>[
  BandMember(
    name: 'Danny',
    role: 'Vocals',
    imageAsset: 'assets/images/members/danny.jpg',
    instagramUrl: Uri(
      scheme: 'https',
      host: 'www.instagram.com',
      path: 'ragtagbirds/',
    ),
    facebookUrl: Uri(
      scheme: 'https',
      host: 'www.facebook.com',
      path: 'ragtagbirds/',
    ),
    emailUrl: Uri(scheme: 'mailto', path: 'danny@ragtagbirds.de'),
  ),

  BandMember(
    name: 'Sebastian',
    role: 'Lead Guitar',
    imageAsset: 'assets/images/members/sebastian.jpg',
    instagramUrl: Uri(
      scheme: 'https',
      host: 'www.instagram.com',
      path: 'ragtagbirds/',
    ),
    facebookUrl: Uri(
      scheme: 'https',
      host: 'www.facebook.com',
      path: 'ragtagbirds/',
    ),
    emailUrl: Uri(scheme: 'mailto', path: 'sebastian@ragtagbirds.de'),
  ),
  BandMember(
    name: 'Joern',
    role: 'Double Bass',
    imageAsset: 'assets/images/members/joern.jpg',
    instagramUrl: Uri(
      scheme: 'https',
      host: 'www.instagram.com',
      path: 'ragtagbirds/',
    ),
    facebookUrl: Uri(
      scheme: 'https',
      host: 'www.facebook.com',
      path: 'ragtagbirds/',
    ),
    emailUrl: Uri(scheme: 'mailto', path: 'joern@ragtagbirds.de'),
  ),
  BandMember(
    name: 'Bjoern',
    role: 'Drums',
    imageAsset: 'assets/images/members/bjoern.jpg',
    instagramUrl: Uri(
      scheme: 'https',
      host: 'www.instagram.com',
      path: 'ragtagbirds/',
    ),
    facebookUrl: Uri(
      scheme: 'https',
      host: 'www.facebook.com',
      path: 'ragtagbirds/',
    ),
    emailUrl: Uri(scheme: 'mailto', path: 'bjoern@ragtagbirds.de'),
  ),
  BandMember(
    name: 'Stefan',
    role: 'Stagepiano',
    imageAsset: 'assets/images/members/stefan.jpg',
    instagramUrl: Uri(
      scheme: 'https',
      host: 'www.instagram.com',
      path: 'ragtagbirds/',
    ),
    facebookUrl: Uri(
      scheme: 'https',
      host: 'www.facebook.com',
      path: 'ragtagbirds/',
    ),
    emailUrl: Uri(scheme: 'mailto', path: 'stefan@ragtagbirds.de'),
  ),
];
