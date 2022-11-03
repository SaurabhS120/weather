import 'package:weather/data/datasource/remote/http_service.dart';
import 'package:weather/data/model/weather_details_model.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/entity/weather_entity.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';

class WeatherDataRepoImpl extends WeatherDataRepo {
  HttpService httpService = HttpService();

  @override
  Future<WeatherEntity> getWeatherData(CityEntity cityEntity) async {
    WeatherDetailsModel response =
        await httpService.getRequest(cityEntity.locationEntity);
    WeatherEntity weatherEntity = WeatherEntity(
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
