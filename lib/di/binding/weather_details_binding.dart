import 'package:get/get.dart';
import 'package:weather/data/repo_impl/lat_long_to_city_name_repo_impl.dart';
import 'package:weather/data/repo_impl/weather_repo_impl.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class WeatherDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WeatherController());
    Get.put(LocationListController());
    Get.put(WeatherDataRepoImpl() as WeatherDataRepo);
    Get.put(WeatherDataUsecase());
    Get.put(LatLongToCityNameRepoImpl() as LatLongToCityNameRepo);
    Get.put(LatLongToCityNameUsecase());
    Get.put(GeoLocationController());
  }
}