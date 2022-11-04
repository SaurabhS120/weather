import 'package:get/get.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';

class LocationListController extends GetxController {
  final RxList<CityEntity> _cityList = RxList<CityEntity>();
  final CitiesLocalRepo citiesLocalRepo = Get.find<CitiesLocalRepo>();

  void initialize() {
    citiesLocalRepo.init();
  }

  void getFromDB() async {
    _cityList.value = await citiesLocalRepo.getCities();
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
}
