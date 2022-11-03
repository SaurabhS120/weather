import 'package:get/get.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/entity/weather_entity.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';

class WeatherDataUsecase {
  WeatherDataRepo weatherDataRepo = Get.find<WeatherDataRepo>();

  WeatherDataUsecase();

  Future<WeatherEntity> invoke(CityEntity cityEntity) async {
    return weatherDataRepo.getWeatherData(cityEntity);
  }
}
