import 'package:get/get.dart';
import 'package:weather/data/repo_impl/weather_repo_impl.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/entity/weather_entity.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';

class WeatherController extends GetxController {
  late LocationEntity locationEntity;

  set(LocationEntity locationEntity) {
    this.locationEntity = locationEntity;
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
    WeatherEntity weatherEntity =
        await weatherDataRepo.getWeatherData(locationEntity);
    _temp.value = weatherEntity.temp;
    _feels_like.value = weatherEntity.feels_like;
    _temp_min.value = weatherEntity.temp_min;
    _temp_max.value = weatherEntity.temp_max;
    _pressure.value = weatherEntity.pressure;
    _humidity.value = weatherEntity.humidity;
    _icon.value = weatherEntity.icon;
    _isLoading.value = false;
  }
}
