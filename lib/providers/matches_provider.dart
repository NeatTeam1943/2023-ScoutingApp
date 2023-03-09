// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/match.dart';

class MatchesProvider with ChangeNotifier {
  final Map<int?, Match> _matches = {};

  List<Match> get matches => _matches.values.toList();

  Match match(int number) {
    return _matches[number]!;
  }

  void addMatch(Match match) {
    _matches[match.number] = match;
    notifyListeners();
  }

  updateMatch(int number, Function(Match m) action) {
    action(_matches[number]!);
    notifyListeners();
  }
}
