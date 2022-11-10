import 'package:get/get.dart';
import 'package:weather/domain/usecase/cities_local_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class LocationListController extends GetxController {
  final RxList<CityItem> _cityList = RxList<CityItem>();
  final RxList<WeatherItem> _weatherList = RxList<WeatherItem>();
  final currentCity = RxString('');
  final CitiesLocalUseCase citiesLocalUsecase = Get.find<CitiesLocalUseCase>();

  RxList<WeatherItem> getWeatherList() => _weatherList;

  void getFromDB() async {
    _cityList.value = (await citiesLocalUsecase.getCities());
    currentCity.value = getCityList().first.cityName;
  }

  void add_city(CityItem cityItem) {
    _cityList.add(cityItem);
    citiesLocalUsecase.addCity(cityItem);
    getFromDB();
    getWeathers();
  }

  void remove(int index) {
    citiesLocalUsecase.removeCity(_cityList[index]);
    getFromDB();
    getWeathers();
  }

  RxList<CityItem> getCityList() => _cityList;

  void setCurrentCity(String s) {
    currentCity.value = s;
  }

  void getWeathers() async {
    List<WeatherItem> list = [];
    for (var e in _cityList.value) {
      try {
        WeatherDataUsecase weatherDataUsecase = Get.find<WeatherDataUsecase>();
        WeatherItem weatherItem = await weatherDataUsecase.invoke(e, 'metric');
        list.add(weatherItem);
      } on Exception catch (e) {
        print(e);
      }
    }
    _weatherList.value = list;
    print("_weatherList len : ${_weatherList.length}");
  }
}
