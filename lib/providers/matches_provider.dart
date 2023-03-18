// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/storage.dart';

class MatchesProvider with ChangeNotifier {
  MatchesProvider() {
    initMatches();
  }

  final Map<int?, Match> _matches = {};

  List<Match> get matches => _matches.values.toList();

  void initMatches() async {
    List<Match>? matchList = await Storage.getMatches();
    if (matchList == null) {
      return;
    }

    for (final match in matchList) {
      addMatch(match, skipSave: true);
    }
  }

  Match match(int number) {
    return _matches[number]!;
  }

  void addMatch(Match match, {bool skipSave = false}) {
    _matches[match.number] = match;
    if (!skipSave) {
      Storage.saveMatches(_matches.values.toList());
    }

    notifyListeners();
  }

  void removeMatch(Match match, {bool skipSave = false}) {
    _matches.remove(match.number);
    if (!skipSave) {
      Storage.saveMatches(_matches.values.toList());
    }

    notifyListeners();
  }

  updateMatch(int number, Function(Match m) action) {
    action(_matches[number]!);
    Storage.saveMatches(_matches.values.toList());
    notifyListeners();
  }
}
