// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/providers/matches_provider.dart';

class MatchState<T extends StatefulWidget> extends State<T> {
  int get _number => ModalRoute.of(context)!.settings.arguments as int;

  /// The current match
  Match get match => Provider.of<MatchesProvider>(context).match(_number);

  /// Like [match] but without listening to changes. Used for state initialization.
  Match get snapshot =>
      Provider.of<MatchesProvider>(context, listen: false).match(_number);

  /// Update the match and notify listeners.
  void updateMatch(Function(Match m) action) {
    Provider.of<MatchesProvider>(context, listen: false)
        .updateMatch(_number, action);
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
