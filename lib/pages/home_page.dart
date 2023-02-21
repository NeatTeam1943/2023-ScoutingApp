// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/utils/frc_teams.dart';
import '../models/team.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  static const routeName = '/';

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Team> _teams = [];

  @override
  void initState() {
    super.initState();
    FrcTeams.getAll().then((teams) => setState(() => _teams = teams));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/add-match'),
            icon: const Icon(Icons.add),
            label: const Text("Game"),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _teams.length,
          itemBuilder: (_, index) => ListTile(
            title: Text(_teams[index].name!),
            subtitle: Text('#${_teams[index].number}'),
          ),
        ),
      ),
    );
  }
}
