import 'package:get/get.dart';
import 'package:weather/domain/entity/city_entity.dart';

class LocationListController extends GetxController {
  final RxList<CityEntity> _city_list = RxList<CityEntity>();

  void add_city(CityEntity cityEntity) {
    _city_list.add(cityEntity);
  }

  RxList<CityEntity> getCityList() => _city_list;
}
