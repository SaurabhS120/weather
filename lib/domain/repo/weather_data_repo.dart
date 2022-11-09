import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/hourly_weather_data_model.dart';
import 'package:weather/domain/model/weather_model.dart';

abstract class WeatherDataRepo {
  Future<WeatherModel> getWeatherData(CityModel cityEntity, String metric);

  @override
  Future<HourlyWeatherDataModel> getHourlyWeatherData(
      CityModel cityModel, String metric);
}
