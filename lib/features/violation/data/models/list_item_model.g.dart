// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListItemModel _$ListItemModelFromJson(Map<String, dynamic> json) =>
    ListItemModel(
      offenceId: (json['offence_id'] as num?)?.toInt(),
      offenceName: json['offence_name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      zoneId: (json['zone_id'] as num?)?.toInt(),
      zoneName: json['zone_name'] as String?,
      commandId: (json['command_id'] as num?)?.toInt(),
      commandName: json['command_name'] as String?,
      vehicleTypeId: (json['vehicle_type_id'] as num?)?.toInt(),
      vehicleBrandId: (json['vehicle_brand_id'] as num?)?.toInt(),
      plateTypeId: (json['plate_type_id'] as num?)?.toInt(),
      eventTypeId: (json['event_type_id'] as num?)?.toInt(),
      eventTypeName: json['event_type_name'] as String?,
      vehicleTypeName: json['vehicle_type_name'] as String?,
      vehicleBrandName: json['vehicle_brand_name'] as String?,
      plateTypeName: json['plate_type_name'] as String?,
      plateColorId: (json['plate_color_id'] as num?)?.toInt(),
      plateColorName: json['plate_color_name'] as String?,
      vehicleColorId: (json['vehicle_color_id'] as num?)?.toInt(),
      vehicleColorName: json['vehicle_color_name'] as String?,
    );

Map<String, dynamic> _$ListItemModelToJson(ListItemModel instance) =>
    <String, dynamic>{
      if (instance.vehicleBrandId case final value?) 'vehicle_brand_id': value,
      if (instance.vehicleBrandName case final value?)
        'vehicle_brand_name': value,
      if (instance.vehicleColorId case final value?) 'vehicle_color_id': value,
      if (instance.vehicleColorName case final value?)
        'vehicle_color_name': value,
      if (instance.vehicleTypeId case final value?) 'vehicle_type_id': value,
      if (instance.vehicleTypeName case final value?)
        'vehicle_type_name': value,
      if (instance.plateTypeId case final value?) 'plate_type_id': value,
      if (instance.plateTypeName case final value?) 'plate_type_name': value,
      if (instance.plateColorId case final value?) 'plate_color_id': value,
      if (instance.plateColorName case final value?) 'plate_color_name': value,
      if (instance.offenceId case final value?) 'offence_id': value,
      if (instance.offenceName case final value?) 'offence_name': value,
      if (instance.amount case final value?) 'amount': value,
      if (instance.zoneId case final value?) 'zone_id': value,
      if (instance.zoneName case final value?) 'zone_name': value,
      if (instance.commandId case final value?) 'command_id': value,
      if (instance.commandName case final value?) 'command_name': value,
      if (instance.eventTypeId case final value?) 'event_type_id': value,
      if (instance.eventTypeName case final value?) 'event_type_name': value,
    };
