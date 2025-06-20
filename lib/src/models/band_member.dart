/// Beispiel:
///   const tina = BandMember(
///     name: 'Tina',
///     role: 'Vocals',
///     imageAsset: 'assets/images/members/tina.jpg',
///     instagramUrl: Uri(
///       scheme: 'https',
///       host: 'instagram.com',
///       path: 'tina',
///     ),
///     emailUrl: Uri(scheme: 'mailto', path: 'tina@ragtagbirds.de'),
///   );

class BandMember {
  /// Anzeigename, z. B. "Tina" oder "Max".
  final String name;

  /// Kurze Rollenbezeichnung (Vocals, Guitar, Drums …).
  final String role;

  /// Asset‑Pfad zum Porträtfoto (in pubspec.yaml registriert).
  final String imageAsset;

  /// Optionaler Instagram‑Link.
  final Uri? instagramUrl;

  /// Optionaler Facebook‑Link.
  final Uri? facebookUrl;

  /// Optionaler Mail‑Link (mailto:…).  Praktisch für Booking‑Anfragen.
  final Uri? emailUrl;

  const BandMember({
    required this.name,
    required this.role,
    required this.imageAsset,
    this.instagramUrl,
    this.facebookUrl,
    this.emailUrl,
  });

  /// True, wenn mindestens ein Social‑Link hinterlegt ist.
  bool get hasSocials =>
      instagramUrl != null || facebookUrl != null || emailUrl != null;

  // --------------------------------------------------------------------------
  //  Convenience: (de-)serialisierung, damit wir die Mitglieder später auch
  //  aus JSON oder einer CMS‑API laden können.
  // --------------------------------------------------------------------------

  factory BandMember.fromJson(Map<String, dynamic> json) => BandMember(
    name: json['name'] as String,
    role: json['role'] as String? ?? '',
    imageAsset: json['imageAsset'] as String,
    instagramUrl: json['instagramUrl'] != null
        ? Uri.parse(json['instagramUrl'] as String)
        : null,
    facebookUrl: json['facebookUrl'] != null
        ? Uri.parse(json['facebookUrl'] as String)
        : null,
    emailUrl: json['emailUrl'] != null
        ? Uri.parse(json['emailUrl'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'role': role,
    'imageAsset': imageAsset,
    if (instagramUrl != null) 'instagramUrl': instagramUrl.toString(),
    if (facebookUrl != null) 'facebookUrl': facebookUrl.toString(),
    if (emailUrl != null) 'emailUrl': emailUrl.toString(),
  };
}
