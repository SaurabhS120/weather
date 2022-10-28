import 'package:weather/domain/entity/weather_entity.dart';
import 'package:weather/domain/repo/location_repo.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';
import 'package:weather/data/datasource/http_service.dart';
import 'package:weather/data/model/weather_details_model.dart';
class WeatherDataRepoImpl extends WeatherDataRepo{
  HttpService httpService = HttpService();
  @override
  Future<WeatherEntity> getWeatherData() async{
    WeatherDetailsModel response = await httpService.getRequest();
    WeatherEntity weatherEntity = WeatherEntity(response.main.temp, response.main.feels_like, response.main.temp_max, response.main.temp_min, response.main.pressure, response.main.humidity);
    return weatherEntity;
  }

}