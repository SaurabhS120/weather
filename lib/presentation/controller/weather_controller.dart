import 'package:get/get.dart';
import 'package:weather/data/repo_impl/weather_repo_impl.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/entity/weather_entity.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';

class WeatherController extends GetxController {
  final cityEntity = Rx<CityEntity?>(null);

  set(CityEntity cityEntity) {
    this.cityEntity.value = cityEntity;
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

  WeatherDataRepo weatherDataRepo = WeatherDataRepoImpl();

  void getWeather() async {
    if (cityEntity.value == null) {
      print('No cities passed to fetch');
    } else {
      WeatherEntity weatherEntity =
          await weatherDataRepo.getWeatherData(cityEntity.value!);
      _temp.value = weatherEntity.temp;
      _feels_like.value = weatherEntity.feelsLike;
      _temp_min.value = weatherEntity.tempMin;
      _temp_max.value = weatherEntity.tempMax;
      _pressure.value = weatherEntity.pressure;
      _humidity.value = weatherEntity.humidity;
      _icon.value = weatherEntity.icon;
      _isLoading.value = false;
    }
  }
}
