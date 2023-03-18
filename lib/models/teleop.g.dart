// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teleop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teleop _$TeleopFromJson(Map<String, dynamic> json) => Teleop()
  ..cycles = (json['cycles'] as List<dynamic>)
      .map((e) => Cycle.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TeleopToJson(Teleop instance) => <String, dynamic>{
      'cycles': instance.cycles.map((e) => e.toJson()).toList(),
    };
