// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/match.dart';

class MatchesProvider with ChangeNotifier {
  final List<Match> _matches = [];

  List<Match> get matches => _matches;

  void addMatch(Match match) {
    _matches.add(match);
    notifyListeners();
  }
}
