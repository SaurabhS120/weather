import 'package:weather/data/datasource/remote/http_service.dart';
import 'package:weather/data/entity/weather_details_entity.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/weather_model.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';

class WeatherDataRepoImpl extends WeatherDataRepo {
  HttpService httpService = HttpService();

  @override
  Future<WeatherModel> getWeatherData(CityModel cityEntity) async {
    WeatherDetailsEntity response =
        await httpService.getWeatherDetails(cityEntity.locationModel);
    WeatherModel weatherEntity = WeatherModel(
        response.main.temp,
        response.main.feels_like,
        response.main.temp_max,
        response.main.temp_min,
        response.main.pressure,
        response.main.humidity,
        response.weather[0].icon);
    print('icon : ${response.weather.map((e) => e.icon)}');
    return weatherEntity;
  }
}
