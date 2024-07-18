import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../utils/share_utils.dart';
import '../../../core/domain/models/game.dart';
import '../../../play_game/presentation/widgets/results/shareable.dart';

/// Shows a modal that displays a shareable widget.
Future<void> showShareModal(BuildContext context, Game game) async {
  final shareKey = GlobalKey();

  return showModalBottomSheet(
    context: context,
    builder: (BuildContext _) {
      return ShareModalContent(shareKey: shareKey, game: game);
    },
  );
}

/// The content of the share modal.
class ShareModalContent extends StatefulWidget {
  /// The key of the widget to share.
  final GlobalKey shareKey;

  /// The game to share.
  final Game game;

  /// Creates a new [ShareModalContent] instance.
  const ShareModalContent({
    required this.shareKey,
    required this.game,
    super.key,
  });

  @override
  State<ShareModalContent> createState() => _ShareModalContentState();
}

class _ShareModalContentState extends State<ShareModalContent> {
  bool _isSharing = false;

  Future<void> handleShare() async {
    setState(() {
      _isSharing = true;
    });

    // Ensure the widget is fully rendered before capturing
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final imageBytes = await capturePng(widget.shareKey);
      final imageFile = await saveImage(imageBytes);
      final xFile = getXFile(imageFile);

      await Share.shareXFiles(
        [xFile],
        subject: 'TileTallier',
        text: 'Score with me next time: bit.ly',
      );

      // Delete the image file after sharing
      await imageFile.delete();
    } catch (e) {
      print('Error capturing and sharing: $e');
    } finally {
      setState(() {
        _isSharing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const <Color>[
            Colors.black87,
            Colors.black12,
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RepaintBoundary(
            key: widget.shareKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Shareable(game: widget.game),
                SizedBox(height: 20),
                if (!_isSharing) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: handleShare,
                        child: const Text('Share'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
