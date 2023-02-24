// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/utils/match_state.dart';

class InGameActionBar extends StatelessWidget implements PreferredSizeWidget {
  const InGameActionBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(113);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: Column(
        children: [
          AppBar(
            title: const Text('Fouls'),
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: const [
              Center(
                child: Text('F'),
              ),
              ActionCounter(foulType: 'foul'),
              Padding(padding: EdgeInsets.only(left: 25)),
              Center(
                child: Text('TF'),
              ),
              ActionCounter(foulType: 'technical_foul'),
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
  });

  final String foulType;

  @override
  State<StatefulWidget> createState() => _ActionCounterState();
}

class _ActionCounterState extends MatchState<ActionCounter> {
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
