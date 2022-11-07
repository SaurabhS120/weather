import 'package:get/get.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class WeatherController extends GetxController {
  final cityItem = Rx<CityItem?>(null);

  set(CityItem cityEntity) {
    this.cityItem.value = cityEntity;
    getWeather();
  }

  final RxBool _isLoading = true.obs;
  final RxDouble _temp = 0.0.obs;
  final RxDouble _feels_like = 0.0.obs;
  final RxDouble _temp_max = 0.0.obs;
  final RxDouble _temp_min = 0.0.obs;
  final RxDouble _pressure = 0.0.obs;
  final RxDouble _humidity = 0.0.obs;
  final RxString _icon = ''.obs;

  RxBool checkLoading() => _isLoading;

  RxDouble getTemp() => _temp;

  RxDouble getFeelsLike() => _feels_like;

  RxDouble getTempMax() => _temp_max;

  RxDouble getTempMin() => _temp_min;

  RxDouble getPressure() => _pressure;

  RxDouble getHumidity() => _humidity;

  RxString getIcon() => _icon;

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
      _temp.value = weatherItem.temp;
      _feels_like.value = weatherItem.feelsLike;
      _temp_min.value = weatherItem.tempMin;
      _temp_max.value = weatherItem.tempMax;
      _pressure.value = weatherItem.pressure;
      _humidity.value = weatherItem.humidity;
      _icon.value = weatherItem.icon;
      _isLoading.value = false;
    }
  }
}
