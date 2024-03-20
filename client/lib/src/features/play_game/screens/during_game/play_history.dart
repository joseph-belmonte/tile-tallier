import 'package:flutter/material.dart';

/// A page that displays the play history
class PlayHistoryPage extends StatefulWidget {
  /// Creates a new [PlayHistoryPage] instance.
  const PlayHistoryPage({super.key});

  @override
  PlayHistoryPageState createState() => PlayHistoryPageState();
}

/// The state for the [PlayHistoryPage] widget.
class PlayHistoryPageState extends State<PlayHistoryPage> {
  bool _interactive = false;

  /// Creates a new [PlayHistoryPageState] instance.
  PlayHistoryPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play History'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _interactive ? _buildLockButton() : _buildEditButton(),
          SizedBox(height: 10),
          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: ClampingScrollPhysics(),
          //     itemCount: 1,
          //     itemBuilder: (context, index) {
          //       return null;
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildLockButton() {
    return ElevatedButton(
      onPressed: () => setState(() => _interactive = false),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.lock, color: Colors.white),
          Text('Lock Play History', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () => setState(() => _interactive = true),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.edit, color: Colors.white),
          Text('Edit Play History', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
