import 'package:weather/domain/entity/location_entity.dart';

abstract class CityNameToLatLonGeoLocRepo {
  Future<LocationEntity> getLocationDetailsFromCity(String cityName);
}
