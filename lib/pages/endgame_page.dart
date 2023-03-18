// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stop_watch_timer/stop_watch_timer.dart';

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

  int currentTime = 0;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (snapshot.endgame == null) {
        updateMatch((m) => m.endgame = Endgame());
      }

      if (snapshot.endgame!.dockedTime == null) {
        _stopWatchTimer.onStartTimer();
        _stopWatchTimer.rawTime.listen((time) => currentTime = time);
      } else {
        currentTime = (snapshot.endgame!.dockedTime! * 1000).toInt();
      }
    });
  }

  bool get didChargeStation =>
      match.endgame != null ? match.endgame!.didChargeStation : false;

  void _setChargeStationState(ChargeStationState css) {
    updateMatch((m) {
      m.endgame!.chargeStationState = css;
      m.endgame!.dockedTime = currentTime / 1000.0;
    });
  }

  void onPop() {
    if (snapshot.endgame!.chargeStationState == null) {
      snapshot.endgame!.chargeStationState = ChargeStationState.failed;
      snapshot.endgame!.dockedTime = currentTime / 1000.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onPop();
        return true;
      },
      child: Scaffold(
        appBar: InGameActionBar(
          onFinish: onPop,
          match: match,
          title: StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            builder: (context, snap) {
              final displayTime =
                  StopWatchTimer.getDisplayTime(currentTime, hours: false);

              return Text("Endgame\n$displayTime");
            },
          ),
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
                      m.endgame?.didChargeStation = value!;
                    });
                  },
                  title: const Text("Did attempt stabilizing?"),
                ),
              ),

              // Charge Station State field
              ChargeStateField(
                value: match.endgame?.chargeStationState,
                onChange: (value) {
                  _setChargeStationState(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
