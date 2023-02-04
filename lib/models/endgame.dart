// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';

class Endgame {
  Endgame({this.didChargeStation = true});

  bool didChargeStation;
  ChargeStationState? chargeStationState;
  double? dockedTime;
}
