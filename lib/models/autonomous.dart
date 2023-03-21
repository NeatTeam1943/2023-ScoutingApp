// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';
import 'package:neatteam_scouting_2023/models/cycle.dart';

part 'autonomous.g.dart';

@JsonSerializable(explicitToJson: true)
class Autonomous {
  Autonomous()
      : cycles = [],
        didChargeStation = false,
        isGamePieceInRobot = false;

  List<Cycle> cycles;
  bool didChargeStation;
  ChargeStationState? chargeStationState;
  bool isGamePieceInRobot;

  void updateCycle(int index, Function(Cycle cycle) action) {
    action(cycles[index]);
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Autonomous.fromJson(Map<String, dynamic> json) =>
      _$AutonomousFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AutonomousToJson(this);
}
