// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cycle _$CycleFromJson(Map<String, dynamic> json) => Cycle(
      cycleNumber: json['cycleNumber'] as int,
      isHalf: json['isHalf'] as bool? ?? false,
    )
      ..isDefended = json['isDefended'] as bool
      ..defendingTeam = json['defendingTeam'] == null
          ? null
          : Team.fromJson(json['defendingTeam'] as Map<String, dynamic>)
      ..gamePiece = $enumDecodeNullable(_$GamePieceEnumMap, json['gamePiece'])
      ..pickupZone =
          $enumDecodeNullable(_$PickupZoneEnumMap, json['pickupZone'])
      ..gridLevel = $enumDecodeNullable(_$GridLevelEnumMap, json['gridLevel'])
      ..gridZone = $enumDecodeNullable(_$GridZoneEnumMap, json['gridZone'])
      ..cycleTime = (json['cycleTime'] as num?)?.toDouble()
      ..isSuccessful = json['isSuccessful'] as bool
      ..finished = json['finished'] as bool;

Map<String, dynamic> _$CycleToJson(Cycle instance) => <String, dynamic>{
      'cycleNumber': instance.cycleNumber,
      'isDefended': instance.isDefended,
      'defendingTeam': instance.defendingTeam?.toJson(),
      'gamePiece': _$GamePieceEnumMap[instance.gamePiece],
      'pickupZone': _$PickupZoneEnumMap[instance.pickupZone],
      'gridLevel': _$GridLevelEnumMap[instance.gridLevel],
      'gridZone': _$GridZoneEnumMap[instance.gridZone],
      'cycleTime': instance.cycleTime,
      'isSuccessful': instance.isSuccessful,
      'isHalf': instance.isHalf,
      'finished': instance.finished,
    };

const _$GamePieceEnumMap = {
  GamePiece.cube: 'cube',
  GamePiece.cone: 'cone',
};

const _$PickupZoneEnumMap = {
  PickupZone.feeder: 'feeder',
  PickupZone.floor: 'floor',
};

const _$GridLevelEnumMap = {
  GridLevel.low: 'low',
  GridLevel.middle: 'middle',
  GridLevel.high: 'high',
};

const _$GridZoneEnumMap = {
  GridZone.onFeeder: 'onFeeder',
  GridZone.coOp: 'coOp',
  GridZone.onBorder: 'onBorder',
};
