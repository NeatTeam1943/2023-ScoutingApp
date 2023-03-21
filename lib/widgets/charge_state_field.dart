// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';
import 'package:neatteam_scouting_2023/widgets/sliding_segmented_control.dart';

class ChargeStateField extends StatelessWidget {
  const ChargeStateField({super.key, required this.onChange, this.value});

  final Function(ChargeStationState?) onChange;
  final ChargeStationState? value;

  @override
  Widget build(BuildContext context) {
    return SlidingSegmentedControl<ChargeStationState>(
      value: value,
      onChange: onChange,
      segments: ChargeStationState.values,
      colors: const {
        ChargeStationState.failed: Colors.redAccent,
        ChargeStationState.engaged: Colors.blueAccent,
        ChargeStationState.docked: Colors.greenAccent
      },
    );
  }
}
