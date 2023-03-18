// Dart imports:
import 'dart:convert';
import 'dart:ui';

// Package imports:
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:neatteam_scouting_2023/providers/matches_provider.dart';
import 'models/match.dart';

enum StorageKeys {
  scouterName,
  matches,
}

class Storage {
  static void saveScouterName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.scouterName.name, name);
  }

  static Future<String?> getScouterName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.scouterName.name);
  }

  static void saveMatches(List<Match> matches) async {
    final prefs = await SharedPreferences.getInstance();

    final matchesStrings = <String>[];
    for (final match in matches) {
      matchesStrings.add(json.encode(match.toJson()));
    }

    await prefs.setStringList(StorageKeys.matches.name, matchesStrings);
  }

  static Future<List<Match>?> getMatches() async {
    final prefs = await SharedPreferences.getInstance();
    final matchesStrings = prefs.getStringList(StorageKeys.matches.name);
    if (matchesStrings == null) {
      return null;
    }

    final matches = <Match>[];
    for (final matchString in matchesStrings) {
      matches.add(Match.fromJson(json.decode(matchString)));
    }

    return matches;
  }
}
