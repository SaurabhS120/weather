import 'package:json_annotation/json_annotation.dart';

part 'weather_section_entity.g.dart';

@JsonSerializable()
class WeatherSectionEntity {
  String icon;
  String main;

  WeatherSectionEntity(this.icon, this.main);

  factory WeatherSectionEntity.fromJson(Map<String, dynamic> json) =>
      _$WeatherSectionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherSectionEntityToJson(this);
}
