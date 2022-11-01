import 'package:get/get.dart';
import 'package:weather/domain/entity/city_entity.dart';

class LocationListController extends GetxController {
  final RxList<CityEntity> _cityList = RxList<CityEntity>();

  void add_city(CityEntity cityEntity) {
    _cityList.add(cityEntity);
  }

  RxList<CityEntity> getCityList() => _cityList;
}
