import 'package:weather/domain/model/location_model.dart';

abstract class CityNameRepo {
  Future<LocationModel> getLocationDetailsFromCity(String cityName);
}
