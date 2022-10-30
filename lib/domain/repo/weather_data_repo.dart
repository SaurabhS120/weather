import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/entity/weather_entity.dart';

abstract class WeatherDataRepo {
  Future<WeatherEntity> getWeatherData(LocationEntity locationEntity);
}
