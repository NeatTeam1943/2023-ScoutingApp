// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/enums/charge_station.dart';

part 'endgame.g.dart';

@JsonSerializable(explicitToJson: true)
class Endgame {
  Endgame({this.didChargeStation = true});

  bool didChargeStation;
  ChargeStationState? chargeStationState;
  double? dockedTime;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Endgame.fromJson(Map<String, dynamic> json) =>
      _$EndgameFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EndgameToJson(this);
}
