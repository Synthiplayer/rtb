// lib/src/models/band_model.dart
library;

/// Model für ein Band-Mitglied oder die Band selbst.
class BandMember {
  /// Anzeigename, z. B. "Tina" oder "Max".
  final String name;

  /// Kurze Rollenbezeichnung (z. B. "Vocals", "Guitar", "Drums").
  final String role;

  /// Asset-Pfad zum Porträtfoto (in pubspec.yaml registriert).
  final String imageAsset;

  /// Optionaler Instagram-Link (z. B. https://instagram.com/…).
  final Uri? instagramUrl;

  /// Optionaler Facebook-Link (z. B. https://facebook.com/…).
  final Uri? facebookUrl;

  /// Optionaler Mail-Link (mailto:…). Praktisch für Booking-Anfragen.
  final Uri? emailUrl;

  /// Freier Text, z. B. Band-History oder persönliche Biografie.
  final String? description;

  /// Erstellt ein [BandMember]-Objekt.
  const BandMember({
    required this.name,
    required this.role,
    required this.imageAsset,
    this.instagramUrl,
    this.facebookUrl,
    this.emailUrl,
    this.description,
  });

  /// True, wenn mindestens ein Social-Link hinterlegt ist.
  bool get hasSocials =>
      instagramUrl != null || facebookUrl != null || emailUrl != null;

  // --------------------------------------------------------------------------
  // Hilfsfunktionen für JSON: Damit lassen sich Bandmitglieder speichern und laden.
  // --------------------------------------------------------------------------

  /// Erstellt ein [BandMember] aus einer JSON-Map.
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
    description: json['description'] as String?,
  );

  /// Konvertiert das [BandMember] in eine JSON-Map.
  Map<String, dynamic> toJson() => {
    'name': name,
    'role': role,
    'imageAsset': imageAsset,
    if (instagramUrl != null) 'instagramUrl': instagramUrl.toString(),
    if (facebookUrl != null) 'facebookUrl': facebookUrl.toString(),
    if (emailUrl != null) 'emailUrl': emailUrl.toString(),
    if (description != null) 'description': description,
  };
}
