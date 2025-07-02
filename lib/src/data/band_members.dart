// lib/src/data/band_members.dart
import '../models/band_model.dart';
import 'member_descriptions.dart';

/// Liste aller Bandmitglieder und der Band selbst als erster Eintrag.
final List<BandMember> bandMembers = [
  BandMember(
    name: 'Ragtag Birds',
    role: '50s & 60s Rock’n’Roll',
    imageAsset: 'assets/images/members/ragtag_birds.jpg',
    instagramUrl: Uri.https('www.instagram.com', 'ragtagbirds/'),
    facebookUrl: Uri.https('www.facebook.com', 'ragtagbirds/'),
    emailUrl: Uri(scheme: 'mailto', path: 'info@ragtagbirds.de'),
    description: MemberDescriptions.ragtagBirds,
  ),
  BandMember(
    name: 'Danny',
    role: 'Vocals',
    imageAsset: 'assets/images/members/danny.jpg',
    instagramUrl: Uri.https('www.instagram.com', 'ragtagbirds/'),
    facebookUrl: Uri.https('www.facebook.com', 'ragtagbirds/'),
    emailUrl: Uri(scheme: 'mailto', path: 'danny@ragtagbirds.de'),
    description: MemberDescriptions.danny,
  ),
  BandMember(
    name: 'Sebastian',
    role: 'Lead Guitar',
    imageAsset: 'assets/images/members/sebastian.jpg',
    instagramUrl: Uri.https('www.instagram.com', 'ragtagbirds/'),
    facebookUrl: Uri.https('www.facebook.com', 'ragtagbirds/'),
    emailUrl: Uri(scheme: 'mailto', path: 'sebastian@ragtagbirds.de'),
    description: MemberDescriptions.sebastian,
  ),
  BandMember(
    name: 'Joern',
    role: 'Double Bass',
    imageAsset: 'assets/images/members/joern.jpg',
    instagramUrl: Uri.https('www.instagram.com', 'ragtagbirds/'),
    facebookUrl: Uri.https('www.facebook.com', 'ragtagbirds/'),
    emailUrl: Uri(scheme: 'mailto', path: 'joern@ragtagbirds.de'),
    description: MemberDescriptions.joern,
  ),
  BandMember(
    name: 'Bjoern',
    role: 'Drums',
    imageAsset: 'assets/images/members/bjoern.jpg',
    instagramUrl: Uri.https('www.instagram.com', 'ragtagbirds/'),
    facebookUrl: Uri.https('www.facebook.com', 'ragtagbirds/'),
    emailUrl: Uri(scheme: 'mailto', path: 'bjoern@ragtagbirds.de'),
    description: MemberDescriptions.bjoern,
  ),
  BandMember(
    name: 'Stefan',
    role: 'Stage Piano',
    imageAsset: 'assets/images/members/stefan.jpg',
    instagramUrl: Uri.https('www.instagram.com', 'synthiplayer/'),
    facebookUrl: Uri.https('www.facebook.com', 'stefan.rose.77/'),
    emailUrl: Uri(scheme: 'mailto', path: 'stefan@ragtagbirds.de'),
    description: MemberDescriptions.stefan,
  ),
];
