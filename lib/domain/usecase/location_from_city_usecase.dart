import 'package:get/get.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/city_name_to_lat_lon_geo_loc_repo.dart';
class LocationFromCityUsecase {
  CityNameToLatLonGeoLocRepo repo = Get.find<CityNameToLatLonGeoLocRepo>();

  Future<LocationEntity> invoke(String cityName) async {
    return await repo.getLocationDetailsFromCity(cityName);
  }
}