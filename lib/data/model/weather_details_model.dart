import 'package:weather/data/model/weather_main_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'weather_details_model.g.dart';
@JsonSerializable()
class WeatherDetailsModel{
   WeatherMain main;
   WeatherDetailsModel(this.main);

  factory WeatherDetailsModel.fromJson(Map<String, dynamic> json) => _$WeatherDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailsModelToJson(this);
}