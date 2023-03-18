// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/pages/cycle_page.dart';
import 'package:neatteam_scouting_2023/utils/match_state.dart';
import '../pages/cycle_page.dart';
import '../providers/matches_provider.dart';

class InGameActionBar extends StatelessWidget implements PreferredSizeWidget {
  const InGameActionBar({
    super.key,
    required this.title,
    this.match,
  });

  final Widget title;
  final Match? match;

  @override
  Size get preferredSize => const Size.fromHeight(113);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        elevation: 0,
      ),
      body: Column(
        children: [
          AppBar(
            title: const Text('Fouls'),
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: [
              const Center(
                child: Text('F'),
              ),
              ActionCounter(foulType: 'foul', match: match),
              const Padding(padding: EdgeInsets.only(left: 25)),
              const Center(
                child: Text('TF'),
              ),
              ActionCounter(foulType: 'technical_foul', match: match),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionCounter extends StatefulWidget {
  const ActionCounter({
    super.key,
    required this.foulType,
    this.match,
  });

  final String foulType;
  final Match? match;

  @override
  State<StatefulWidget> createState() => _ActionCounterState(match: match);
}

class _ActionCounterState extends MatchState<ActionCounter> {
  _ActionCounterState({Match? match}) : super(match: match);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () =>
              updateMatch((m) => m.decrementFouls(widget.foulType)),
          icon: const Icon(Icons.remove),
        ),
        Text(match.getFouls(widget.foulType).toString()),
        IconButton(
          onPressed: () =>
              updateMatch((m) => m.incrementFouls(widget.foulType)),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
