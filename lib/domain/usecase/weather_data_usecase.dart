import 'package:get/get.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/weather_model.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';

class WeatherDataUsecase {
  WeatherDataRepo weatherDataRepo = Get.find<WeatherDataRepo>();

  WeatherDataUsecase();

  Future<WeatherModel> invoke(CityModel cityEntity) async {
    return weatherDataRepo.getWeatherData(cityEntity);
  }
}
