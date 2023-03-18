// Project imports:
import 'package:neatteam_scouting_2023/enums/alliance.dart';
import 'package:neatteam_scouting_2023/enums/driver_station.dart';
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/endgame.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/models/teleop.dart';

class Match {
  Match({required this.scouterName})
      : fouls = 0,
        technicalFouls = 0,
        team = Team(),
        finished = false;

  String scouterName;

  Team team;

  int? number;
  Alliance? alliance;
  DriverStation? driverStation;

  int fouls;
  int technicalFouls;

  Autonomous? autonomous;
  Teleop? teleop;
  Endgame? endgame;

  bool finished;

  incrementFouls(type) {
    if (type == 'technical_foul') {
      technicalFouls++;
    } else {
      fouls++;
    }
  }

  decrementFouls(type) {
    if (type == 'technical_foul' && technicalFouls > 0) {
      technicalFouls--;
    } else if (fouls > 0) {
      fouls--;
    }
  }

  getFouls(type) {
    if (type == 'technical_foul') {
      return technicalFouls;
    }
    return fouls;
  }
}
