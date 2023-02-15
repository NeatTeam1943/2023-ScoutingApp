// Package imports:
import 'package:csv/csv.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/match.dart';

String makeMatchDataCSV(List<Match> matches) {
  List<List<String>> records = [];
  for (int i = 0; i < matches.length; i++) {
    Match match = matches[i];
    records.add([
      "${i + 1}",
      match.team.number!.toString(),
      match.team.name!,
      match.number.toString(),
      match.alliance!.name,
      match.driverStation!.value.toString(),
      match.fouls.toString(),
      match.technicalFouls.toString(),
      (match.autonomous?.didChargeStation ?? false).toString(),
      match.autonomous?.chargeStationState?.name ?? '',
      (match.endgame?.didChargeStation ?? false).toString(),
      match.endgame?.chargeStationState?.name ?? '',
      match.endgame?.dockedTime?.toString() ?? '',
    ]);
  }

  return const ListToCsvConverter().convert(records);
}
