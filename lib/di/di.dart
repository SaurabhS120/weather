import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:weather/data/repo_impl/city_name_to_lat_lon_geo_loc_repo_impl.dart';
import 'package:weather/data/repo_impl/weather_repo_impl.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class DI {
  static void injectAll() {
    Get.put(Dio(
      BaseOptions(baseUrl: 'http://api.openweathermap.org'),
    ));
    Get.put(LocationFromCityUsecase(CiityNameToLatLonGeoLocRepoImpl()));
    Get.put(WeatherDataUsecase(WeatherDataRepoImpl()));
    Get.put(GeoLocationController());
    Get.put(WeatherController());
    Get.put(LocationListController());
  }
}
