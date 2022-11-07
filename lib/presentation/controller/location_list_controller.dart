import 'package:get/get.dart';
import 'package:weather/domain/usecase/cities_local_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';

class LocationListController extends GetxController {
  final RxList<CityItem> _cityList = RxList<CityItem>();
  final currentCity = RxString('');
  final CitiesLocalUseCase citiesLocalUsecase = Get.find<CitiesLocalUseCase>();

  void getFromDB() async {
    _cityList.value = (await citiesLocalUsecase.getCities());
    currentCity.value = getCityList().first.cityName;
  }

  void add_city(CityItem cityItem) {
    _cityList.add(cityItem);
    citiesLocalUsecase.addCity(cityItem);
  }

  void remove(int index) {
    citiesLocalUsecase.removeCity(_cityList[index]);
    // _cityList.removeAt(index);
    getFromDB();
  }

  RxList<CityItem> getCityList() => _cityList;

  void setCurrentCity(String s) {
    currentCity.value = s;
  }
}
