// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/utils/match_state.dart';

// Package imports:

class InGameActionBar extends StatelessWidget implements PreferredSizeWidget {
  const InGameActionBar({
    super.key,
    required this.title,
    this.match,
    this.onFinish,
    this.showFinish,
  });

  final Widget title;
  final Match? match;
  final VoidCallback? onFinish;
  final bool? showFinish;

  @override
  Size get preferredSize => const Size.fromHeight(113);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        elevation: 0,
        actions: [
          if (showFinish ?? true)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo),
                ),
                onPressed: match!.finished
                    ? null
                    : () {
                        match!.finished = true;
                        if (onFinish != null) {
                          onFinish!();
                        }

                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                child: const Text('Finish'),
              ),
            ),
        ],
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
  // ignore: no_logic_in_create_state
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
