import 'package:get/get.dart';
import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/usecase/hourly_weather_data_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';
import 'package:weather/presentation/item/unit_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class WeatherController extends GetxController {
  final cityItem = Rx<CityItem?>(null);
  Rx<UnitItem> unit = UnitItem(MetricUnitItem()).obs;

  set(CityItem cityItem) {
    _isLoading.value = true;
    this.cityItem.value = cityItem;
    getWeather();
    getHourlyWeather();
    _isLoading.value = false;
  }

  final _weatherItem = WeatherItem("", 0, 0, 0, 0, 0, 0, '', '').obs;
  final _hourlyWeatherItem = HourlyWeatherDataItem([]).obs;
  final RxBool _isLoading = true.obs;

  RxBool checkLoading() => _isLoading;

  Rx<WeatherItem> getWeatherItem() => _weatherItem;

  Rx<HourlyWeatherDataItem> getHourlyWeatherItem() => _hourlyWeatherItem;

  @override
  void onInit() {
    super.onInit();
  }

  void getWeather() async {
    if (cityItem.value == null) {
      print('No cities passed to fetch');
    } else {
      WeatherDataUsecase weatherDataUsecase = Get.find<WeatherDataUsecase>();
      WeatherItem weatherItem = await weatherDataUsecase.invoke(
          cityItem.value!, unit.value.unit.getUnitName());
      _weatherItem.value = weatherItem;
      _isLoading.value = false;
    }
  }

  void getHourlyWeather() async {
    if (cityItem.value == null) {
      print('No cities passed to fetch');
    } else {
      HourlyWeatherDataUseCase hourlyWeatherDataUseCase =
          Get.find<HourlyWeatherDataUseCase>();
      HourlyWeatherDataItem hourlyWeatherItem = await hourlyWeatherDataUseCase
          .invoke(cityItem.value!.toModel(), unit.value.unit.getUnitName());
      _hourlyWeatherItem.value = hourlyWeatherItem;
      _isLoading.value = false;
    }
  }

  toggleUnit() {
    _isLoading.value = true;
    unit.value = unit.value.toggle();
    getWeather();
    getHourlyWeather();
    _isLoading.value = false;
  }
}
