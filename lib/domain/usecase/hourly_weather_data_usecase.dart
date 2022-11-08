import 'package:get/get.dart';
import 'package:weather/domain/mappers/hourly_weather_mapper.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';

class HourlyWeatherDataUseCase {
  WeatherDataRepo repo = Get.find<WeatherDataRepo>();

  Future<HourlyWeatherDataItem> invoke(CityModel cityModel) async {
    return (await repo.getHourlyWeatherData(cityModel)).toItem();
  }
}
