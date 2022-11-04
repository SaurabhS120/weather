import 'package:get/get.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';

class LatLongToCityNameUsecase {
  LatLongToCityNameRepo latLongToCityNameRepo =
      Get.find<LatLongToCityNameRepo>();

  LatLongToCityNameUsecase();

  Future<String> invoke(LocationModel location) {
    return latLongToCityNameRepo.getCityName(location);
  }
}
