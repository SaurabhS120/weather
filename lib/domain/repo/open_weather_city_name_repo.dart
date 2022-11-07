import 'package:weather/domain/model/location_model.dart';

abstract class OpenWeatherCityNameRepo {
  Future<LocationModel> getLocationDetailsFromCity(String cityName);
}
