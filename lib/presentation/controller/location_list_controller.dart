import 'package:get/get.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';

class LocationListController extends GetxController {
  final RxList<CityModel> _cityList = RxList<CityModel>();
  final currentCity = RxString('');
  final CitiesLocalRepo citiesLocalRepo = Get.find<CitiesLocalRepo>();

  void getFromDB() async {
    _cityList.value = await citiesLocalRepo.getCities();
    currentCity.value = getCityList().first.cityName;
  }

  void add_city(CityModel cityEntity) {
    _cityList.add(cityEntity);
    citiesLocalRepo.addCity(cityEntity);
  }

  void remove(int index) {
    citiesLocalRepo.removeCity(_cityList[index]);
    // _cityList.removeAt(index);
    getFromDB();
  }

  RxList<CityModel> getCityList() => _cityList;

  void setCurrentCity(String s) {
    currentCity.value = s;
  }
}
