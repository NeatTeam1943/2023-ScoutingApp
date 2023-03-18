// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/cycle_data_csv.dart';
import 'package:neatteam_scouting_2023/match_data_csv.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/providers/matches_provider.dart';
import 'package:neatteam_scouting_2023/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  static const routeName = '/';

  final String title;

  void _deleteMatch(BuildContext context, Match match) {
    Provider.of<MatchesProvider>(context, listen: false).removeMatch(match);
  }

  List<Match>? _getMatches(BuildContext context) {
    List<Match> matches =
        Provider.of<MatchesProvider>(context, listen: false).matches;

    if (matches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No matches data found'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return null;
    }

    return matches;
  }

  void _saveMatchesCSV(BuildContext context, List<Match> matches) {
    String matchesCSV = makeMatchDataCSV(matches);
    saveToDownloads(csv: matchesCSV, filename: 'GameData');
  }

  void _saveCyclesCSV(BuildContext context, List<Match> matches) {
    String cyclesCSV = makeCycleDataCSV(matches);
    saveToDownloads(csv: cyclesCSV, filename: 'CycleData');
  }

  void _openShareBottomSheet(BuildContext context) {
    List<Match>? matches = _getMatches(context);
    if (matches == null) {
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              // Bottom Sheet Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Export CSV',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Export Matches CSV
              ElevatedButton(
                child: const Text(
                  'Game Data',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => _saveMatchesCSV(context, matches),
              ),

              // Export Cycles CSV
              ElevatedButton(
                child: const Text(
                  'Cycles Data',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => _saveCyclesCSV(context, matches),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, model, child) {
        List<Match> matches =
            Provider.of<MatchesProvider>(context, listen: true).matches;
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: false,
            actions: [
              TextButton.icon(
                onPressed: () => _openShareBottomSheet(context),
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
              itemCount: matches.length,
              itemBuilder: (_, index) => Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) =>
                          _deleteMatch(context, matches[index]),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text('Match #${matches[index].number}'),
                  subtitle: Text(
                      '${matches[index].team.name} #${matches[index].team.number}'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/match',
                      arguments: matches[index].number,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
