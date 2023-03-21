// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/alliance.dart';
import 'package:neatteam_scouting_2023/enums/driver_station.dart';
import 'package:neatteam_scouting_2023/models/autonomous.dart';
import 'package:neatteam_scouting_2023/models/endgame.dart';
import 'package:neatteam_scouting_2023/models/team.dart';
import 'package:neatteam_scouting_2023/models/teleop.dart';

part 'match.g.dart';

@JsonSerializable(explicitToJson: true)
class Match {
  Match({this.scouterName = ''})
      : fouls = 0,
        technicalFouls = 0,
        didDie = false,
        team = Team(),
        finished = false;

  String scouterName;

  Team team;

  int? number;
  Alliance? alliance;
  DriverStation? driverStation;

  int fouls;
  int technicalFouls;
  bool didDie;

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

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MatchToJson(this);
}
