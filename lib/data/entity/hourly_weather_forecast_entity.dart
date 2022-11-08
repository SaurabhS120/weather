import 'package:json_annotation/json_annotation.dart';

part 'hourly_weather_forecast_entity.g.dart';

@JsonSerializable()
class HourlyWeatherForecastEntity {
  List<HourlyWeatherDetailsEntity> list;

  HourlyWeatherForecastEntity(this.list);

  factory HourlyWeatherForecastEntity.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherForecastEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherForecastEntityToJson(this);
}

@JsonSerializable()
class HourlyWeatherDetailsEntity {
  int dt;
  HourlyWeatherMain main;
  List<HourlyWeatherSection> weather;

  HourlyWeatherDetailsEntity(this.dt, this.main, this.weather);

  factory HourlyWeatherDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherDetailsEntityToJson(this);
}

@JsonSerializable()
class HourlyWeatherMain {
  double temp;

  HourlyWeatherMain(this.temp);

  factory HourlyWeatherMain.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherMainFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherMainToJson(this);
}

@JsonSerializable()
class HourlyWeatherSection {
  String main;

  HourlyWeatherSection(this.main);

  factory HourlyWeatherSection.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherSectionFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherSectionToJson(this);
}
