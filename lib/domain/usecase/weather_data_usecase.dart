import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/mappers/weather_mapper.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class WeatherDataUsecase {
  WeatherDataRepo weatherDataRepo;

  WeatherDataUsecase(this.weatherDataRepo);

  Future<WeatherItem> invoke(CityItem city, String metric) async {
    return (await weatherDataRepo.getWeatherData(city.toModel(), metric))
        .toItem();
  }
}
