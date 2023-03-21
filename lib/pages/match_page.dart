// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/utils/match_state.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  static const routeName = '/match';

  @override
  State<StatefulWidget> createState() => _MatchPageState();
}

class _MatchPageState extends MatchState<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match #${match.number}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/autonomous',
                  arguments: snapshot.number,
                ),
                child: const Text(
                  'AUTONOMOUS',
                  style: TextStyle(fontSize: 46),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/teleop',
                  arguments: snapshot.number,
                ),
                child: const Text(
                  'TELEOP',
                  style: TextStyle(fontSize: 46),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/endgame',
                  arguments: snapshot.number,
                ),
                child: const Text(
                  'ENDGAME',
                  style: TextStyle(fontSize: 46),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/notes',
                  arguments: snapshot.number,
                ),
                child: const Text(
                  'MATCH NOTES',
                  style: TextStyle(fontSize: 46),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
