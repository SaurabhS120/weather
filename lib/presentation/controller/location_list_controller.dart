import 'package:get/get.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';

class LocationListController extends GetxController {
  final RxList<CityEntity> _cityList = RxList<CityEntity>();
  final currentCity = RxString('');
  final CitiesLocalRepo citiesLocalRepo = Get.find<CitiesLocalRepo>();

  void getFromDB() async {
    _cityList.value = await citiesLocalRepo.getCities();
    currentCity.value = getCityList().first.cityName;
  }

  void add_city(CityEntity cityEntity) {
    _cityList.add(cityEntity);
    citiesLocalRepo.addCity(cityEntity);
  }

  void remove(int index) {
    citiesLocalRepo.removeCity(_cityList[index]);
    // _cityList.removeAt(index);
    getFromDB();
  }

  RxList<CityEntity> getCityList() => _cityList;

  void setCurrentCity(String s) {
    currentCity.value = s;
  }
}
