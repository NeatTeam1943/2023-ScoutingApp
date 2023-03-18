// Project imports:
import 'package:neatteam_scouting_2023/enums/game_piece.dart';
import 'package:neatteam_scouting_2023/enums/grid_level.dart';
import 'package:neatteam_scouting_2023/enums/grid_zone.dart';
import 'package:neatteam_scouting_2023/enums/pickup_zone.dart';
import 'package:neatteam_scouting_2023/models/team.dart';

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
}
