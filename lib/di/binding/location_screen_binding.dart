import 'package:get/get.dart';
import 'package:weather/data/repo_impl/city_name_to_lat_lon_geo_loc_repo_impl.dart';
import 'package:weather/data/repo_impl/lat_long_to_city_name_repo_impl.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';

class LocationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CiityNameToLatLonGeoLocRepoImpl());
    Get.put(LocationFromCityUsecase());
    Get.put(LocationListController());
    Get.put(LatLongToCityNameRepoImpl() as LatLongToCityNameRepo);
    Get.put(LatLongToCityNameUsecase());
    Get.put(GeoLocationController());
  }
}