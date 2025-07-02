# Tourdaten (tour.json)

Jeder Eintrag ist ein Objekt mit folgenden Feldern:

| Feld               | Typ      | Pflicht? | Beschreibung                                                      |
|--------------------|----------|----------|-------------------------------------------------------------------|
| `event`            | String   | ✅        | Name des Events                                                  |
| `date`             | String   | ✅        | Datum im ISO-Format `YYYY-MM-DD`                                  |
| `time`             | String   | ❌        | Uhrzeit, z. B. `"20:00"`                                          |
| `city`             | String   | ❌        | Stadtname                                                         |
| `venue`            | String   | ❌        | Veranstaltungsort                                                 |
| `advance`          | String   | ❌        | Vorverkaufspreis, z. B. `"13,00 €"`                               |
| `before`           | String   | ❌        | Abendkassenpreis, z. B. `"15,00 €"`                               |
| `url`              | String   | ❌        | **Ticket-Link** (wenn leer → kein Ticket)                        |
| `eventlink`        | String   | ❌        | **Event-Info** (z. B. Presse- oder Detailseite)                  |
| `subtitle`         | String   | ❌        | Kurzer Zusatztext unter dem Event-Titel                          |
| `organizer`        | String   | ❌        | Veranstalter-Name                                                |
| `organizer_street` | String   | ❌        | Straße & Hausnummer des Veranstalters                            |
| `organizer_city`   | String   | ❌        | PLZ & Ort des Veranstalters                                      |

**Pflicht**: `event`, `date`  
Alle anderen Felder sind optional und können weggelassen werden.

## Beispiel (maximalausgestattet)

```json
[
  {
    "event":            "Ragtag Birds",
    "subtitle":         "Fantastischer Rock'n'Roll aus den 50er und 60er Jahren.",
    "date":             "2025-11-08",
    "time":             "20:00",
    "city":             "Osterbruch",
    "venue":            "Osterbrucher Mühle",
    "advance":          "13,00 €",
    "before":           "15,00 €",
    "url":              "https://tickets.example.com/ragtag-birds",
    "eventlink":        "https://www.kultur-pur-osterbruch.de/jahres-übersicht-2025/",
    "organizer":        "KulturPur Osterbruch e. V.",
    "organizer_street": "Dorfstraße 13",
    "organizer_city":   "21762 Osterbruch"
  },
  {
    "event": "Open Air Special",
    "date":  "2025-08-02",
    "city":  "München",
    "venue": "Rockhalle"
    // kein advance, before, url, eventlink → Eintritt frei
  }
]
