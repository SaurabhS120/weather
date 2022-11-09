import 'package:intl/intl.dart';
import 'package:weather/data/entity/weather_details_entity.dart';
import 'package:weather/domain/model/weather_model.dart';

extension WeatherEntityToModel on WeatherDetailsEntity {
  WeatherModel toModel() {
    return WeatherModel(
        millisToDate(dt),
        main.temp,
        main.feels_like,
        main.temp_max,
        main.temp_min,
        main.pressure,
        main.humidity,
        weather[0].icon,
        weather[0].main);
  }

  String millisToDate(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);

// 12 Hour format:
    var d12 = DateFormat('EEE, MMM d').format(dt);
    return d12;
  }
}
