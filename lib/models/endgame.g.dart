// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endgame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Endgame _$EndgameFromJson(Map<String, dynamic> json) => Endgame(
      didChargeStation: json['didChargeStation'] as bool? ?? true,
    )
      ..chargeStationState = $enumDecodeNullable(
          _$ChargeStationStateEnumMap, json['chargeStationState'])
      ..dockedTime = (json['dockedTime'] as num?)?.toDouble();

Map<String, dynamic> _$EndgameToJson(Endgame instance) => <String, dynamic>{
      'didChargeStation': instance.didChargeStation,
      'chargeStationState':
          _$ChargeStationStateEnumMap[instance.chargeStationState],
      'dockedTime': instance.dockedTime,
    };

const _$ChargeStationStateEnumMap = {
  ChargeStationState.docked: 'docked',
  ChargeStationState.engaged: 'engaged',
  ChargeStationState.failed: 'failed',
};
