import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/entity/weather_main_entity.dart';
import 'package:weather/data/entity/weather_section_entity.dart';

part 'weather_details_entity.g.dart';

@JsonSerializable()
class WeatherDetailsEntity {
  int dt;
  WeatherMain main;
  List<WeatherSectionEntity> weather;

  WeatherDetailsEntity(this.dt, this.main, this.weather);

  factory WeatherDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$WeatherDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailsEntityToJson(this);
}
