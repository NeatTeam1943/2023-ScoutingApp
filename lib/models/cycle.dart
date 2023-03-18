// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/game_piece.dart';
import 'package:neatteam_scouting_2023/enums/grid_level.dart';
import 'package:neatteam_scouting_2023/enums/grid_zone.dart';
import 'package:neatteam_scouting_2023/enums/pickup_zone.dart';
import 'package:neatteam_scouting_2023/models/team.dart';

part 'cycle.g.dart';

@JsonSerializable(explicitToJson: true)
class Cycle {
  Cycle({
    required this.cycleNumber,
    this.isHalf = false,
  })  : isDefended = false,
        isSuccessful = true,
        finished = false;

  int cycleNumber;
  bool isDefended;
  Team? defendingTeam;
  GamePiece? gamePiece;
  PickupZone? pickupZone;
  GridLevel? gridLevel;
  GridZone? gridZone;
  double? cycleTime;
  bool isSuccessful;
  bool isHalf;

  bool finished;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Cycle.fromJson(Map<String, dynamic> json) => _$CycleFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CycleToJson(this);
}
