import 'package:get/get.dart';
import 'package:weather/domain/mappers/location_mapper.dart';
import 'package:weather/domain/repo/open_weather_city_name_repo.dart';
import 'package:weather/presentation/item/location_item.dart';

class LocationFromCityUsecase {
  OpenWeatherCityNameRepo repo = Get.find<OpenWeatherCityNameRepo>();

  Future<LocationItem> invoke(String cityName) async {
    return (await repo.getLocationDetailsFromCity(cityName)).toItem();
  }
}