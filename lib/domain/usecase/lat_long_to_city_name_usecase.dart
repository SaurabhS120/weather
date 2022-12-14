import 'package:get/get.dart';
import 'package:weather/domain/mappers/location_mapper.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';
import 'package:weather/presentation/item/location_item.dart';

class LatLongToCityNameUsecase {
  LatLongToCityNameRepo latLongToCityNameRepo =
      Get.find<LatLongToCityNameRepo>();

  LatLongToCityNameUsecase();

  Future<String> invoke(LocationItem location) {
    return latLongToCityNameRepo.getCityName(location.toModel());
  }
}
