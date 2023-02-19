// Flutter imports:
import 'package:flutter/material.dart';
import 'package:neatteam_scouting_2023/pages/autonomous_page.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/pages/home_page.dart';
import 'package:neatteam_scouting_2023/pages/match_page.dart';
import 'package:neatteam_scouting_2023/pages/team_info_page.dart';
import 'package:neatteam_scouting_2023/providers/matches_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: const ScoutingApp(),
    create: (_) => MatchesProvider(),
  ));
}

class ScoutingApp extends StatelessWidget {
  const ScoutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.routeName: (context) =>
            const HomePage(title: 'NeatTeam Scouting 2023'),
        TeamInfoPage.routeName: (context) => const TeamInfoPage(),
        MatchPage.routeName: (context) => const MatchPage(),
        AutonomousPage.routeName: (context) => const AutonomousPage(),
      },
    );
  }
}
