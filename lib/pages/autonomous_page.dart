// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';
import 'package:neatteam_scouting_2023/utils/match_state.dart';
import 'package:neatteam_scouting_2023/widgets/cycles_list.dart';
import 'package:neatteam_scouting_2023/widgets/in_game_action_bar.dart';

class AutonomousPage extends StatefulWidget {
  const AutonomousPage({super.key});

  static const routeName = '/autonomous';

  @override
  State<StatefulWidget> createState() => _AutonomousState();
}

class _AutonomousState extends MatchState<AutonomousPage> {
  final _formKey = GlobalKey<FormState>();

  final _changeStateColors = <ChargeStationState, Color>{
    ChargeStationState.failed: Colors.redAccent,
    ChargeStationState.engaged: Colors.blueAccent,
    ChargeStationState.docked: Colors.greenAccent
  };

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

  ChargeStationState get chargeStationStateColorValue =>
      match.autonomous != null
          ? (match.autonomous!.chargeStationState ?? ChargeStationState.failed)
          : ChargeStationState.failed;

  List<Cycle> get cycles =>
      match.autonomous != null ? match.autonomous!.cycles : [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InGameActionBar(
        title: 'Autonomous',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            StyleFormField(
              field: CheckboxListTile(
                value: didChargeStation,
                onChanged: (value) {
                  updateMatch((m) {
                    m.autonomous?.didChargeStation = value!;
                  });
                },
                title: const Text("Charged"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text("Charge station state"),
            ),
            CupertinoSlidingSegmentedControl<ChargeStationState>(
              thumbColor: _changeStateColors[chargeStationStateColorValue]!,
              groupValue: match.autonomous?.chargeStationState,
              children: const <ChargeStationState, Widget>{
                ChargeStationState.failed: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Failed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ChargeStationState.engaged: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Engaged',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ChargeStationState.docked: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Docked',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              },
              onValueChanged: (value) {
                _setChargeStationState(value!);
              },
            ),
            StyleFormField(
              field: CheckboxListTile(
                value: match.autonomous?.isGamePieceInRobot,
                tristate: true,
                onChanged: (value) {
                  updateMatch((m) => m.autonomous?.isGamePieceInRobot = value!);
                },
                title: const Text("Robot has game piece"),
              ),
            ),
            CyclesList(
              list: cycles,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          updateMatch((m) => m.autonomous?.cycles
              .add(Cycle(cycleNumber: m.autonomous!.cycles.length + 1)));
        },
        label: const Text('Add cycle'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}