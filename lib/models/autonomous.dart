// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';

class Autonomous {
  Autonomous()
      : cycles = [],
        didChargeStation = false,
        isGamePieceInRobot = true;

  List<Cycle> cycles;
  bool didChargeStation;
  ChargeStationState? chargeStationState;
  bool isGamePieceInRobot;

  void updateCycle(int index, Function(Cycle cycle) action) {
    action(cycles[index]);
  }
}
