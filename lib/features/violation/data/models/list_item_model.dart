import 'package:json_annotation/json_annotation.dart';

part 'list_item_model.g.dart';

@JsonSerializable()
class ListItemModel {
  @JsonKey(name: 'vehicle_brand_id', includeIfNull: false)
  final int? vehicleBrandId;
  @JsonKey(name: 'vehicle_brand_name', includeIfNull: false)
  final String? vehicleBrandName;

  @JsonKey(name: 'vehicle_color_id', includeIfNull: false)
  final int? vehicleColorId;
  @JsonKey(name: 'vehicle_color_name', includeIfNull: false)
  final String? vehicleColorName;

  @JsonKey(name: 'vehicle_type_id', includeIfNull: false)
  final int? vehicleTypeId;
  @JsonKey(name: 'vehicle_type_name', includeIfNull: false)
  final String? vehicleTypeName;

  @JsonKey(name: 'plate_type_id', includeIfNull: false)
  final int? plateTypeId;
  @JsonKey(name: 'plate_type_name', includeIfNull: false)
  final String? plateTypeName;

  @JsonKey(name: 'plate_color_id', includeIfNull: false)
  final int? plateColorId;
  @JsonKey(name: 'plate_color_name', includeIfNull: false)
  final String? plateColorName;

  @JsonKey(name: 'offence_id', includeIfNull: false)
  final int? offenceId;
  @JsonKey(name: 'offence_name', includeIfNull: false)
  final String? offenceName;

  @JsonKey(name: 'zone_id', includeIfNull: false)
  final int? zoneId;
  @JsonKey(name: 'zone_name', includeIfNull: false)
  final String? zoneName;

  @JsonKey(name: 'command_id', includeIfNull: false)
  final int? commandId;
  @JsonKey(name: 'command_name', includeIfNull: false)
  final String? commandName;

  @JsonKey(name: 'event_type_id', includeIfNull: false)
  final int? eventTypeId;
  @JsonKey(name: 'event_type_name', includeIfNull: false)
  final String? eventTypeName;

  // … add fields for event_type_id & name …

  ListItemModel({
    this.offenceId,
    this.offenceName,
    this.zoneId,
    this.zoneName,
    this.commandId,
    this.commandName,
    this.vehicleTypeId,
    this.vehicleBrandId,
    this.plateTypeId,
    this.eventTypeId,
    this.eventTypeName,
    this.vehicleTypeName,
    this.vehicleBrandName,
    this.plateTypeName,
    this.plateColorId,
    this.plateColorName,
    this.vehicleColorId,
    this.vehicleColorName,
  });

  factory ListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ListItemModelFromJson(json);
}
