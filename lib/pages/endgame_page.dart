// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';
import 'package:neatteam_scouting_2023/models/endgame.dart';
import 'package:neatteam_scouting_2023/styles/style_form_field.dart';
import 'package:neatteam_scouting_2023/utils/match_state.dart';
import 'package:neatteam_scouting_2023/widgets/charge_state_field.dart';
import 'package:neatteam_scouting_2023/widgets/in_game_action_bar.dart';

class EndgamePage extends StatefulWidget {
  const EndgamePage({super.key});

  static const routeName = '/endgame';

  @override
  State<StatefulWidget> createState() => EndgameState();
}

class EndgameState extends MatchState<EndgamePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (snapshot.endgame == null) {
        updateMatch((m) => m.endgame = Endgame());
      }
    });
  }

  bool get didChargeStation =>
      match.endgame != null ? match.endgame!.didChargeStation : false;

  void _setChargeStationState(ChargeStationState css) {
    updateMatch((m) => m.endgame!.chargeStationState = css);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InGameActionBar(
        title: Text('Endgame'),
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
                    m.endgame?.didChargeStation = value!;
                  });
                },
                title: const Text("Charged"),
              ),
            ),
            ChargeStateField(
              value: match.endgame?.chargeStationState,
              onChange: (value) {
                _setChargeStationState(value!);
              },
            ),
            StyleFormField(
              field: TextFormField(
                autofocus: false,
                initialValue: (snapshot.endgame?.dockedTime ?? 0.0).toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  updateMatch(
                      (m) => m.endgame?.dockedTime = double.tryParse(value));
                },
                decoration: const InputDecoration(
                    labelText: "Time docked (in seconds)"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
