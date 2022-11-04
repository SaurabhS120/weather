import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/weather_model.dart';

abstract class WeatherDataRepo {
  Future<WeatherModel> getWeatherData(CityModel cityEntity);
}
