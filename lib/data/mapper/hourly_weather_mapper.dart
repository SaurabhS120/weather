import 'package:weather/data/entity/hourly_weather_forecast_entity.dart';
import 'package:weather/domain/model/hourly_weather_data_model.dart';

extension HourlyWeatherEntityMapper on HourlyWeatherForecastEntity {
  HourlyWeatherDataModel toModel() {
    return HourlyWeatherDataModel(list
        .map((e) => SingleHourDataModel(e.main.temp, e.weather[0].main))
        .toList());
  }
}
