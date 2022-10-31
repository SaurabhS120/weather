import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

import 'presentation/location_list_screen.dart';
import 'presentation/location_screen.dart';
import 'presentation/main_screen.dart';

void main() {
  Get.put(GeoLocationController());
  Get.put(WeatherController());
  Get.put(LocationListController());

  runApp(GetMaterialApp(
    home: LocationListScreen(),
    getPages: [
      GetPage(
        name: '/location',
        page: () => LocationScreen(),
      ),
      GetPage(
        name: '/location_list',
        page: () => LocationListScreen(),
      ),
      GetPage(
        name: '/home',
        page: () => MainScreen(),
      ),
    ],
  ));
}
