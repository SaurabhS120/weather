import 'package:json_annotation/json_annotation.dart';
part 'weather_section_model.g.dart';
@JsonSerializable()
class WeatherSectionModel {
  String icon;
  WeatherSectionModel(this.icon);

  factory WeatherSectionModel.fromJson(Map<String, dynamic> json) => _$WeatherSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherSectionModelToJson(this);

}