import 'package:flutter/material.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

// import '../../../../utils/game_play_storage.dart';
// import '../../../../utils/toast.dart';
import '../../../edit_settings/presentation/screens/settings.dart';
import '../../../play_game/presentation/screens/pre_game.dart';
import '../../../view_past_games/presentation/screens/past_games.dart';
import '../widgets/pre_paywall_dialog.dart';

/// The home page for the Scrabble app.
class HomePage extends StatelessWidget {
  /// Creates a new [HomePage] instance.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TileTallier',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _validateGameplay(context),
              icon: Icon(Icons.play_arrow_rounded),
              label: Text('Play Game'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PastGamesPage()),
              ),
              icon: Icon(Icons.history_edu),
              label: Text('View History'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              ),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }

  /// Determines if the user can play a game. Routes to the [PreGamePage] if they can, presents
  /// a [PrePaywallDialogue] if they cannot.
  void _validateGameplay(BuildContext context) async {
    // final hasPlayed = await GamePlayStorage.hasPlayedToday();
    // if (!hasPlayed) {
    //   if (!context.mounted) return;
    //   Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const PreGamePage()),
    //   );
    //   return;
    // }
    // final customerInfo = await Purchases.getCustomerInfo();
    // if (customerInfo.entitlements.active.isNotEmpty) {
    //   if (!context.mounted) return;
    //   Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const PreGamePage()),
    //   );
    // } else {
    //   try {
    //     if (!context.mounted) return;

    //     showDialog(
    //       context: context,
    //       builder: (_) => PrePaywallDialogue(),
    //     );
    //   } catch (e) {
    //     if (!context.mounted) return;
    //     ToastService.error(context, 'Error fetching customer info');
    //   }
    // }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PreGamePage()),
    );
  }
}
