import 'package:weather/data/datasource/remote/http_service.dart';
import 'package:weather/data/mapper/city_mapper.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/open_weather_city_name_repo.dart';

class OpenWeatherCityNameRepoImpl extends OpenWeatherCityNameRepo {
  HttpService httpService = HttpService();

  @override
  Future<LocationModel> getLocationDetailsFromCity(String cityName) async {
    var response = await httpService.getCityNameFromLoc(cityName);
    LocationModel locationEntity = response.toModel();
    return locationEntity;
  }
}
