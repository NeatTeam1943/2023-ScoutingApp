// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../models/cycle.dart';

class CyclesList extends StatelessWidget {
  const CyclesList({super.key, required this.list});

  final List<Cycle> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Cycle cycle = list[index];
          return ListTile(
            title: Text("Cycle ${cycle.cycleNumber}"),
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    ));
  }
}
