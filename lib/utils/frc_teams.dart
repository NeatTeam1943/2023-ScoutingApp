// Package imports:
import 'package:csv/csv.dart';

// Project imports:
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
          ..number = e[0]
          ..name = e[1])
        .toList();
  }

  /// Extract team number from "<Team name> #<Team number>"
  static Team makeTeamFromText(String fullTeamText) {
    List<String> parts = fullTeamText.split(" #");
    return Team()
      ..number = int.parse(parts[1])
      ..name = parts[0];
  }
}
