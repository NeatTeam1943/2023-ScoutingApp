// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      scouterName: json['scouterName'] as String? ?? '',
    )
      ..team = Team.fromJson(json['team'] as Map<String, dynamic>)
      ..number = json['number'] as int?
      ..alliance = $enumDecodeNullable(_$AllianceEnumMap, json['alliance'])
      ..driverStation =
          $enumDecodeNullable(_$DriverStationEnumMap, json['driverStation'])
      ..fouls = json['fouls'] as int
      ..technicalFouls = json['technicalFouls'] as int
      ..didDie = json['didDie'] as bool
      ..autonomous = json['autonomous'] == null
          ? null
          : Autonomous.fromJson(json['autonomous'] as Map<String, dynamic>)
      ..teleop = json['teleop'] == null
          ? null
          : Teleop.fromJson(json['teleop'] as Map<String, dynamic>)
      ..endgame = json['endgame'] == null
          ? null
          : Endgame.fromJson(json['endgame'] as Map<String, dynamic>)
      ..notes = json['notes'] as String?
      ..finished = json['finished'] as bool;

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'scouterName': instance.scouterName,
      'team': instance.team.toJson(),
      'number': instance.number,
      'alliance': _$AllianceEnumMap[instance.alliance],
      'driverStation': _$DriverStationEnumMap[instance.driverStation],
      'fouls': instance.fouls,
      'technicalFouls': instance.technicalFouls,
      'didDie': instance.didDie,
      'autonomous': instance.autonomous?.toJson(),
      'teleop': instance.teleop?.toJson(),
      'endgame': instance.endgame?.toJson(),
      'notes': instance.notes,
      'finished': instance.finished,
    };

const _$AllianceEnumMap = {
  Alliance.red: 'red',
  Alliance.blue: 'blue',
};

const _$DriverStationEnumMap = {
  DriverStation.first: 'first',
  DriverStation.second: 'second',
  DriverStation.third: 'third',
};
