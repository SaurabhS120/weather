import 'package:weather/domain/model/location_model.dart';

abstract class CityNameToLatLonGeoLocRepo {
  Future<LocationModel> getLocationDetailsFromCity(String cityName);
}
