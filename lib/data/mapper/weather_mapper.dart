import 'package:weather/data/entity/weather_details_entity.dart';
import 'package:weather/data/entity/weather_main_entity.dart';
import 'package:weather/data/entity/weather_section_entity.dart';
import 'package:weather/domain/model/weather_model.dart';

extension WeatherEntityToModel on WeatherDetailsEntity {
  WeatherModel toModel() {
    return WeatherModel(
        main.temp,
        main.feels_like,
        main.temp_max,
        main.temp_min,
        main.pressure,
        main.humidity,
        weather[0].icon,
        weather[0].main);
  }
}

extension WeatherEntityToModelMapper on WeatherModel {
  WeatherDetailsEntity toModel() {
    return WeatherDetailsEntity(
        WeatherMain(temp, feelsLike, tempMax, tempMin, pressure, humidity),
        [WeatherSectionEntity(icon, main)]);
  }
}
