import 'package:get/get.dart';
import 'package:weather/domain/usecase/cities_local_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';

class LocationListController extends GetxController {
  final RxList<CityItem> _cityList = RxList<CityItem>();
  final currentCity = RxString('');
  final CitiesLocalUseCase citiesLocalRepo = Get.find<CitiesLocalUseCase>();

  void getFromDB() async {
    _cityList.value = (await citiesLocalRepo.getCities());
    currentCity.value = getCityList().first.cityName;
  }

  void add_city(CityItem cityItem) {
    _cityList.add(cityItem);
    citiesLocalRepo.addCity(cityItem);
  }

  void remove(int index) {
    citiesLocalRepo.removeCity(_cityList[index]);
    // _cityList.removeAt(index);
    getFromDB();
  }

  RxList<CityItem> getCityList() => _cityList;

  void setCurrentCity(String s) {
    currentCity.value = s;
  }
}
