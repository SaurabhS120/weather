import 'package:weather/data/datasource/remote/http_service.dart';
import 'package:weather/data/entity/hourly_weather_forecast_entity.dart';
import 'package:weather/data/entity/weather_details_entity.dart';
import 'package:weather/data/mapper/hourly_weather_mapper.dart';
import 'package:weather/data/mapper/weather_mapper.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/hourly_weather_data_model.dart';
import 'package:weather/domain/model/weather_model.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';

class WeatherDataRepoImpl extends WeatherDataRepo {
  HttpService httpService = HttpService();

  @override
  Future<WeatherModel> getWeatherData(CityModel cityEntity) async {
    WeatherDetailsEntity response =
        await httpService.getWeatherDetails(cityEntity.locationModel);
    WeatherModel weatherEntity = response.toModel();
    print('icon : ${response.weather.map((e) => e.icon)}');
    return weatherEntity;
  }

  @override
  Future<HourlyWeatherDataModel> getHourlyWeatherData(
      CityModel cityModel) async {
    HourlyWeatherForecastEntity response =
        await httpService.getHourlyForecast(cityModel.locationModel);
    HourlyWeatherDataModel weatherModel = response.toModel();
    return weatherModel;
  }
}
