import 'package:get/get.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/city_name_to_lat_lon_geo_loc_repo.dart';

class LocationFromCityUsecase {
  CityNameToLatLonGeoLocRepo repo = Get.find<CityNameToLatLonGeoLocRepo>();

  Future<LocationModel> invoke(String cityName) async {
    return await repo.getLocationDetailsFromCity(cityName);
  }
}