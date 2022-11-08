import 'package:get/get.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class WeatherController extends GetxController {
  final cityItem = Rx<CityItem?>(null);

  set(CityItem cityItem) {
    this.cityItem.value = cityItem;
    getWeather();
  }

  final _weatherItem = WeatherItem(0, 0, 0, 0, 0, 0, '', '').obs;
  final RxBool _isLoading = true.obs;

  RxBool checkLoading() => _isLoading;

  Rx<WeatherItem> getWeatherItem() => _weatherItem;

  @override
  void onInit() {
    getWeather();
    super.onInit();
  }

  void getWeather() async {
    if (cityItem.value == null) {
      print('No cities passed to fetch');
    } else {
      WeatherDataUsecase weatherDataUsecase = Get.find<WeatherDataUsecase>();
      WeatherItem weatherItem =
          await weatherDataUsecase.invoke(cityItem.value!);
      _weatherItem.value = weatherItem;
      _isLoading.value = false;
    }
  }
}
