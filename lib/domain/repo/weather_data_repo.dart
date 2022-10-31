import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/entity/weather_entity.dart';

abstract class WeatherDataRepo {
  Future<WeatherEntity> getWeatherData(CityEntity cityEntity);
}
