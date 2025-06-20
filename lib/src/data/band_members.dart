// lib/src/data/band_members.dart
//
// Kompile‑Time‑konstante Liste aller Bandmitglieder.
// Hinweis: Für jede Person muss das Bild unter assets/images/members/<name>.jpg
// vorhanden sein und in pubspec.yaml gelistet werden.

import 'package:rtb/src/models/band_member.dart';

const bandMembers = <BandMember>[
  const BandMember(
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

  const BandMember(
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
  const BandMember(
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
  const BandMember(
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
  const BandMember(
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
];
