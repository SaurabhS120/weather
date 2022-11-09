import 'package:intl/intl.dart';
import 'package:weather/data/entity/hourly_weather_forecast_entity.dart';
import 'package:weather/domain/model/hourly_weather_data_model.dart';
extension HourlyWeatherEntityMapper on HourlyWeatherForecastEntity {
  HourlyWeatherDataModel toModel() {
    return HourlyWeatherDataModel(list
        .map((e) => SingleHourDataModel(
            _millsToTime(e.dt * 1000), e.main.temp, e.weather[0].main))
        .toList());
  }

  String _millsToTime(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);

// 12 Hour format:
    String time = DateFormat('j').format(dt);
    return time;
  }
}
