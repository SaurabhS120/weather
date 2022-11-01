import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class DI {
  static void injectAll() {
    Get.put(GeoLocationController());
    Get.put(WeatherController());
    Get.put(LocationListController());
  }
}
