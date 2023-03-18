// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:neatteam_scouting_2023/models/cycle.dart';

part 'teleop.g.dart';

@JsonSerializable(explicitToJson: true)
class Teleop {
  Teleop() : cycles = [];

  List<Cycle> cycles;

  updateCycle(int index, Function(Cycle cycle) action) {
    action(cycles[index]);
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Teleop.fromJson(Map<String, dynamic> json) => _$TeleopFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TeleopToJson(this);
}
