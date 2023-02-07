import 'package:flutter/material.dart';
import 'package:neatteam_scouting_2023/models/match.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  static const routeName = '/match';

  @override
  State<StatefulWidget> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    final gameObj = ModalRoute.of(context)!.settings.arguments as Match;
    return Scaffold(
      appBar: AppBar(
          title: Text('Match #${gameObj.matchNumber}')
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
              'START CYCLE',
              style: TextStyle(fontSize: 50)
          ),
        ),
      ),
    );
  }
}