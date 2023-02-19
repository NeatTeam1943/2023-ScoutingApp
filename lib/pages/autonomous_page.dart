// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';

class AutonomousPage extends StatefulWidget {
  const AutonomousPage({super.key});

  static const routeName = '/autonomous';

  @override
  State<StatefulWidget> createState() => _AutonomousState();
}

class _AutonomousState extends State<AutonomousPage> {
  final _formKey = GlobalKey<FormState>();
  Autonomous model = Autonomous();

  final _changeStateColors = <ChargeStationState, Color>{
    ChargeStationState.failed: Colors.redAccent,
    ChargeStationState.engaged: Colors.blueAccent,
    ChargeStationState.docked: Colors.greenAccent
  };

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    model.chargeStationState = ChargeStationState.failed;
  }

  void _setChargeStationState(ChargeStationState css) {
    setState(() {
      model.chargeStationState = css;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autonomous"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            StyleFormField(
              field: CheckboxListTile(
                value: model.didChargeStation,
                onChanged: (value) {
                  setState(() {
                    model.didChargeStation = value!;
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
              thumbColor: _changeStateColors[model.chargeStationState]!,
              groupValue: model.chargeStationState,
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
                value: model.isGamePieceInRobot,
                onChanged: (value) {
                  setState(() {
                    model.isGamePieceInRobot = value!;
                  });
                },
                title: const Text("Robot has game piece"),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: model.cycles.length,
                  itemBuilder: (_, index) {
                    Cycle cycle = model.cycles[index];
                    return ListTile(
                      title: Text("Cycle ${cycle.cycleNumber}"),
                      onTap: () => Navigator.pushNamed(context, '/cycle',
                          arguments: cycle),
                    );
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            model.cycles.add(Cycle(cycleNumber: model.cycles.length + 1));
          });
        },
        label: const Text('Add cycle'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
