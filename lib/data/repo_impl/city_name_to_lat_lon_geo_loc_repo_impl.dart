import 'package:weather/data/datasource/remote/http_service.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/city_name_to_lat_lon_geo_loc_repo.dart';

class CiityNameToLatLonGeoLocRepoImpl extends CityNameToLatLonGeoLocRepo {
  HttpService httpService = HttpService();

  @override
  Future<LocationModel> getLocationDetailsFromCity(String cityName) async {
    var response = await httpService.getCityNameFromLoc(cityName);
    LocationModel locationEntity = LocationModel(response.lat, response.lon);
    return locationEntity;
  }
}
