// Flutter imports:
import 'package:flutter/material.dart';
import 'package:neatteam_scouting_2023/pages/home_page.dart';
import 'package:neatteam_scouting_2023/pages/match_page.dart';
import 'package:neatteam_scouting_2023/pages/team_info_form_page.dart';

void main() {
  runApp(const ScoutingApp());
}

class ScoutingApp extends StatelessWidget {
  const ScoutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.routeName: (context) => const HomePage(title: 'NeatTeam Scouting 2023'),
        TeamInfoFormPage.routeName: (context) => const TeamInfoFormPage(),
        MatchPage.routeName: (context) => const MatchPage()
      },
    );
  }
}