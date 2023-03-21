// Package imports:
import 'package:csv/csv.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/models/teleop.dart';

void addCycle({
  required List<List<String>> records,
  required Match match,
  required Cycle cycle,
  required String stage,
  required int totalIteration,
  required int gameIteration,
}) {
  records.add([
    "${totalIteration + 1}",
    "${gameIteration + 1}",
    match.team.number!.toString(),
    match.number.toString(),
    cycle.cycleNumber.toString(),
    stage,
    (cycle.gamePiece?.name ?? "").toString(),
    (cycle.pickupZone?.name ?? "").toString(),
    (cycle.gridLevel?.name ?? "").toString(),
    (cycle.gridZone?.value ?? "").toString(),
    cycle.isSuccessful.toString(),
    cycle.isHalf.toString(),
    cycle.isDefended.toString(),
    cycle.defendingTeam != null ? cycle.defendingTeam!.number.toString() : '',
    (cycle.cycleTime ?? "").toString()
  ]);
  totalIteration++;
  gameIteration++;
}

String makeCycleDataCSV(List<Match> matches) {
  List<List<String>> records = [];

  int totalIteration = 0;
  for (Match match in matches) {
    int gameIteration = 0;

    Autonomous autonomous = match.autonomous ?? Autonomous();
    for (Cycle cycle in autonomous.cycles) {
      addCycle(
        records: records,
        match: match,
        cycle: cycle,
        stage: "Autonomous",
        totalIteration: totalIteration,
        gameIteration: gameIteration,
      );
    }

    Teleop teleop = match.teleop ?? Teleop();
    for (Cycle cycle in teleop.cycles) {
      addCycle(
        records: records,
        match: match,
        cycle: cycle,
        stage: "Teleop",
        totalIteration: totalIteration,
        gameIteration: gameIteration,
      );
    }
  }

  return const ListToCsvConverter().convert(records);
}
