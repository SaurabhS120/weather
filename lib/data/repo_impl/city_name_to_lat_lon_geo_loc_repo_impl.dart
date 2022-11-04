import 'package:weather/data/datasource/remote/http_service.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/city_name_to_lat_lon_geo_loc_repo.dart';

class CiityNameToLatLonGeoLocRepoImpl extends CityNameToLatLonGeoLocRepo {
  HttpService httpService = HttpService();

  @override
  Future<LocationEntity> getLocationDetailsFromCity(String cityName) async {
    var response = await httpService.getCityNameFromLoc(cityName);
    LocationEntity locationEntity = LocationEntity(response.lat, response.lon);
    return locationEntity;
  }
}
