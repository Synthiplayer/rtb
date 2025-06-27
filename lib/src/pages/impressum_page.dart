import 'package:flutter/material.dart';
import '../components/band_drawer.dart';
import '../components/responsive_scaffold.dart';

class ImpressumPage extends StatelessWidget {
  const ImpressumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      drawer: const BandDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Angaben gemäß § 5 TMG',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Text(
              'Ragtag Birds GbR\n'
              'Pulverweg 12\n'
              '21682 Stade',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 24),

            Text(
              'Vertreten durch:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'D. Reinhardt\n'
              'Telefon: +49 151 24101764\n'
              'E-Mail: danny@ragtagbirds.de\n',
              style: TextStyle(height: 1.4),
            ),
            const Text(
              'S. Rose\n'
              'Telefon: +49 176 20147550\n'
              'E-Mail: stefan@ragtagbirds.de',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 32),

            Text('Kontakt:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            const Text(
              'E-Mail: danny@ragtagbirds.de\n'
              'E-Mail: stefan@ragtagbirds.de',
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 32),

            Text(
              'Haftung für Inhalte',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. '
              'Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen. '
              'Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt.',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 20),
            Text(
              'Haftung für Links',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'Unser Angebot enthält ggf. Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss haben. '
              'Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich.',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 20),
            Text(
              'Urheberrecht',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. '
              'Beiträge Dritter sind als solche gekennzeichnet. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers.',
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
