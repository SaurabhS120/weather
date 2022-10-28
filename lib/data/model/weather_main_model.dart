import 'package:json_annotation/json_annotation.dart';
part 'weather_main_model.g.dart';
@JsonSerializable()
class WeatherMain{
  double temp;
  double feels_like;
  double temp_max;
  double temp_min;
  double pressure;
  double humidity;
  WeatherMain(this.temp,this.feels_like,this.temp_max,this.temp_min,this.pressure,this.humidity);

  factory WeatherMain.fromJson(Map<String, dynamic> json) => _$WeatherMainFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);

}