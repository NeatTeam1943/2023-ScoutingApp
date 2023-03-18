// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/teleop.dart';
import 'package:neatteam_scouting_2023/utils/match_state.dart';
import 'package:neatteam_scouting_2023/widgets/cycles_list.dart';
import 'package:neatteam_scouting_2023/widgets/in_game_action_bar.dart';
import '../models/cycle.dart';
import 'cycle_page.dart';

class TeleopPage extends StatefulWidget {
  const TeleopPage({super.key});

  static const routeName = '/teleop';

  @override
  State<StatefulWidget> createState() => TeleopState();
}

class TeleopState extends MatchState<TeleopPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (snapshot.teleop == null) {
        updateMatch((m) => m.teleop = Teleop());
      }
    });
  }

  List<Cycle> get cycles => match.teleop != null ? match.teleop!.cycles : [];

  void pushCyclePage() async {
    int index = snapshot.teleop!.cycles.length;
    updateMatch((m) => addCycle(m.teleop!.cycles));
    bool? isSuccessful = await Navigator.of(context).pushNamed(
      '/cycle',
      arguments: CyclePageProps(
        title: "Teleop",
        cycle: index,
        updateCycle: (Function(Cycle cycle) action) {
          updateMatch((m) => m.teleop?.updateCycle(index, action));
        },
        match: snapshot.number!,
      ),
    ) as bool?;

    if (isSuccessful == null) {
      updateMatch((m) => m.teleop!.cycles.removeLast());
    } else if (isSuccessful) {
      pushCyclePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InGameActionBar(
        title: Text('Teleop'),
      ),
      body: Column(
        children: [
          CyclesList(
            contextTitle: "Teleop",
            list: cycles,
            updateCycle: (int index, Function(Cycle cycle) action) {
              updateMatch((m) => m.teleop?.updateCycle(index, action));
            },
            match: match.number!,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: pushCyclePage,
        label: const Text('Add cycle'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
