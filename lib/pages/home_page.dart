// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/match_data_csv.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/providers/matches_provider.dart';
import 'package:neatteam_scouting_2023/utils/frc_teams.dart';
import 'package:neatteam_scouting_2023/utils/utils.dart';

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
            onPressed: _saveCSV,
            icon: const Icon(Icons.share),
            label: const Text("Share"),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/add-match'),
            icon: const Icon(Icons.add),
            label: const Text("Game"),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _teams.length,
          itemBuilder: (_, index) => ListTile(
            title: Text(_teams[index].name ?? ''),
            subtitle: Text('#${_teams[index].number}'),
          ),
        ),
      ),
    );
  }

  void _saveCSV() {
    List<Match> matches =
        Provider.of<MatchesProvider>(context, listen: false).matches;

    if (matches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No matches data found'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    String csv = makeMatchDataCSV(matches);
    saveToDownloads(filename: 'match-data.csv', content: csv);
  }
}
