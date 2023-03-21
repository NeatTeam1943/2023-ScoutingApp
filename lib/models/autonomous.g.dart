// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autonomous.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Autonomous _$AutonomousFromJson(Map<String, dynamic> json) => Autonomous()
  ..cycles = (json['cycles'] as List<dynamic>)
      .map((e) => Cycle.fromJson(e as Map<String, dynamic>))
      .toList()
  ..didChargeStation = json['didChargeStation'] as bool
  ..chargeStationState = $enumDecodeNullable(
      _$ChargeStationStateEnumMap, json['chargeStationState'])
  ..isGamePieceInRobot = json['isGamePieceInRobot'] as bool;

Map<String, dynamic> _$AutonomousToJson(Autonomous instance) =>
    <String, dynamic>{
      'cycles': instance.cycles.map((e) => e.toJson()).toList(),
      'didChargeStation': instance.didChargeStation,
      'chargeStationState':
          _$ChargeStationStateEnumMap[instance.chargeStationState],
      'isGamePieceInRobot': instance.isGamePieceInRobot,
    };

const _$ChargeStationStateEnumMap = {
  ChargeStationState.docked: 'docked',
  ChargeStationState.engaged: 'engaged',
  ChargeStationState.failed: 'failed',
};
