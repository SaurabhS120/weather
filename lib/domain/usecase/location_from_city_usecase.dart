import 'package:get/get.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/open_weather_city_name_repo.dart';

class LocationFromCityUsecase {
  OpenWeatherCityNameRepo repo = Get.find<OpenWeatherCityNameRepo>();

  Future<LocationModel> invoke(String cityName) async {
    return await repo.getLocationDetailsFromCity(cityName);
  }
}