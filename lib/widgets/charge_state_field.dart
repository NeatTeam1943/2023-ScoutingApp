// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';

class ChargeStateField extends StatelessWidget {
  ChargeStateField({super.key, required this.onChange, this.value});

  final Function(ChargeStationState?) onChange;
  final ChargeStationState? value;

  final _changeStateColors = <ChargeStationState, Color>{
    ChargeStationState.failed: Colors.redAccent,
    ChargeStationState.engaged: Colors.blueAccent,
    ChargeStationState.docked: Colors.greenAccent
  };

  ChargeStationState get _value => value ?? ChargeStationState.failed;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
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
      groupValue: value,
      thumbColor: _changeStateColors[_value]!,
      onValueChanged: onChange,
    );
  }
}
