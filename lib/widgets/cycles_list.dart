// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/pages/cycle_page.dart';

class CyclesList extends StatelessWidget {
  const CyclesList({
    super.key,
    required this.contextTitle,
    required this.list,
    required this.updateCycle,
    required this.match,
  });

  final String contextTitle;
  final List<Cycle> list;
  final Function(int index, Function(Cycle cycle) action) updateCycle;
  final int match;

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
            onTap: () {
              Navigator.of(context).pushNamed('/cycle',
                  arguments: CyclePageProps(
                    title: contextTitle,
                    cycle: index,
                    updateCycle: ((Function(Cycle c) action) {
                      updateCycle(index, action);
                    }),
                    match: match,
                  ));
            },
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    ));
  }
}
