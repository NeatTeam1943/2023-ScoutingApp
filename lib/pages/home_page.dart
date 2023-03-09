// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/match_data_csv.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/providers/matches_provider.dart';
import 'package:neatteam_scouting_2023/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  static const routeName = '/';

  final String title;

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
                onPressed: () => _saveCSV(context),
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
              itemBuilder: (_, index) => ListTile(
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
        );
      },
    );
  }

  void _saveCSV(context) {
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
