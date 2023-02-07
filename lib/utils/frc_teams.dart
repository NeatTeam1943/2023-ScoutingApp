import 'package:csv/csv.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/utils/utils.dart';

class FrcTeams {
  static Future<List<Team>> getAll() async {
    String teamsFileData = await loadAsset('assets/teams.csv');

    return const CsvToListConverter()
        .convert(
          teamsFileData,
          eol: '\n',
        )
        .map((e) => Team()
          ..teamNumber = e[0]
          ..teamName = e[1])
        .toList();
  }
}
