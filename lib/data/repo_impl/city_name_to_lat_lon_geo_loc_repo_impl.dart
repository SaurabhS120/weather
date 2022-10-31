import 'package:weather/data/datasource/lat_long_from_city.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/city_name_to_lat_lon_geo_loc_repo.dart';

class CiityNameToLatLonGeoLocRepoImpl extends CityNameToLatLonGeoLocRepo {
  LatLongFromCityService latLongFromCityService = LatLongFromCityService();

  @override
  Future<LocationEntity> getLocationDetailsFromCity(String cityName) async {
    var response = await latLongFromCityService.getRequest(cityName);
    LocationEntity locationEntity = LocationEntity(response.lat, response.lon);
    return locationEntity;
  }
}
