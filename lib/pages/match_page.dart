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
      appBar: AppBar(title: Text('Match #${match.number}')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'START CYCLE',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
