// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/utils/string_ext.dart';

class SlidingSegmentedControl<T extends Enum> extends StatelessWidget {
  const SlidingSegmentedControl({
    super.key,
    this.value,
    required this.onChange,
    required this.segments,
    this.colors,
  });

  final Function(T?) onChange;
  final T? value;
  final List<T>? segments;
  final Map<T, Color>? colors;

  @override
  Widget build(BuildContext context) {
    Map<T, Widget> children = {};
    for (T seg in segments!) {
      children.addAll({
        seg: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            seg.name.capitalize(),
            style:
                TextStyle(color: (value == seg) ? Colors.white : Colors.black),
          ),
        ),
      });
    }

    return CupertinoSlidingSegmentedControl<T>(
      children: children,
      groupValue: value,
      thumbColor: colors?[value] ?? Colors.blueAccent,
      onValueChanged: onChange,
    );
  }
}
