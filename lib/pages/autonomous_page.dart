// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';
import 'package:neatteam_scouting_2023/utils/match_state.dart';
import 'package:neatteam_scouting_2023/widgets/charge_state_field.dart';
import 'package:neatteam_scouting_2023/widgets/cycles_list.dart';
import 'package:neatteam_scouting_2023/widgets/in_game_action_bar.dart';
import 'cycle_page.dart';

class AutonomousPage extends StatefulWidget {
  const AutonomousPage({super.key});

  static const routeName = '/autonomous';

  @override
  State<StatefulWidget> createState() => _AutonomousState();
}

class _AutonomousState extends MatchState<AutonomousPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (snapshot.autonomous == null) {
        updateMatch((m) => m.autonomous = Autonomous());
      }
    });
  }

  void _setChargeStationState(ChargeStationState css) {
    updateMatch((m) => m.autonomous!.chargeStationState = css);
  }

  bool get didChargeStation =>
      match.autonomous != null ? match.autonomous!.didChargeStation : false;

  bool get isGamePieceInRobot =>
      match.autonomous != null ? match.autonomous!.isGamePieceInRobot : false;

  ChargeStationState get chargeStationStateColorValue =>
      match.autonomous != null
          ? (match.autonomous!.chargeStationState ?? ChargeStationState.failed)
          : ChargeStationState.failed;

  List<Cycle> get cycles =>
      match.autonomous != null ? match.autonomous!.cycles : [];

  void pushCyclePage() async {
    int index = snapshot.autonomous!.cycles.length;
    updateMatch((m) => addCycle(m.autonomous!.cycles));
    bool? isSuccessful = await Navigator.of(context).pushNamed(
      '/cycle',
      arguments: CyclePageProps(
        title: "Auto",
        cycle: index,
        updateCycle: (Function(Cycle cycle) action) {
          updateMatch((m) => m.autonomous?.updateCycle(index, action));
        },
        match: snapshot.number!,
      ),
    ) as bool?;

    if (isSuccessful == null) {
      updateMatch((m) => m.autonomous!.cycles.removeLast());
    } else if (isSuccessful) {
      pushCyclePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InGameActionBar(
        showFinish: false,
        match: match,
        title: const Text('Autonomous'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Did Attempt Stabilizing field
            StyleFormField(
              field: CheckboxListTile(
                value: didChargeStation,
                onChanged: (value) {
                  updateMatch((m) {
                    m.autonomous?.didChargeStation = value!;
                  });
                },
                title: const Text("Did attempt stabilizing?"),
              ),
            ),

            // Charge Station State field
            Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: const Text("Charge station state"),
            ),
            AbsorbPointer(
              absorbing: !(match.autonomous?.didChargeStation ?? true),
              child: ChargeStateField(
                value: match.autonomous?.chargeStationState,
                onChange: (value) {
                  _setChargeStationState(value!);
                },
              ),
            ),

            // Game Piece In Robot field
            StyleFormField(
              field: CheckboxListTile(
                value: isGamePieceInRobot,
                onChanged: (value) {
                  updateMatch((m) {
                    m.autonomous?.isGamePieceInRobot = value!;
                  });
                },
                title: const Text("Robot has game piece"),
              ),
            ),

            // Cycles list
            CyclesList(
                contextTitle: "Auto",
                list: cycles,
                updateCycle: (int index, Function(Cycle cycle) action) {
                  updateMatch((m) => m.autonomous?.updateCycle(index, action));
                },
                match: match.number!),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Add cycle
          FloatingActionButton.extended(
            onPressed: pushCyclePage,
            label: const Text('Add cycle'),
            icon: const Icon(Icons.add),
          ),

          // Move to teleop
          FloatingActionButton.extended(
            heroTag: 'move-page',
            onPressed: () => Navigator.pushNamed(
              context,
              '/teleop',
              arguments: snapshot.number,
            ),
            label: const Text('Teleop'),
            icon: const Icon(Icons.chevron_right),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
