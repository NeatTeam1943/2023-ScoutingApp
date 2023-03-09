// Package imports:
import 'package:csv/csv.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';
import 'package:neatteam_scouting_2023/models/match.dart';
import 'package:neatteam_scouting_2023/models/teleop.dart';

void addCycle(List<List<String>> records, Match match, Cycle cycle,
    String stage, int totalIteration, int gameIteration) {
  records.add([
    "${totalIteration + 1}",
    "${gameIteration + 1}",
    match.team.number!.toString(),
    cycle.cycleNumber.toString(),
    stage,
    cycle.gamePiece!.toString(),
    cycle.pickupZone!.toString(),
    cycle.gridLevel!.toString(),
    cycle.gridZone!.value.toString(),
    cycle.isSuccessful.toString(),
    cycle.isHalf.toString(),
    cycle.isDefended.toString(),
    cycle.defendingTeam != null ? cycle.defendingTeam!.number.toString() : '',
    cycle.cycleTime!.toString()
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
          records, match, cycle, "Autonomous", totalIteration, gameIteration);
    }

    Teleop teleop = match.teleop ?? Teleop();
    for (Cycle cycle in teleop.cycles) {
      addCycle(records, match, cycle, "Teleop", totalIteration, gameIteration);
    }
  }

  return const ListToCsvConverter().convert(records);
}
