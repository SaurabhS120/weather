import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

import 'presentation/location_screen.dart';
import 'presentation/main_screen.dart';

void main() {
  Get.put(GeoLocationController());
  Get.put(WeatherController());

  runApp(GetMaterialApp(
    home: LocationScreen(),
    getPages: [
      GetPage(
        name: '/location',
        page: () => LocationScreen(),
      ),
      GetPage(
        name: '/home',
        page: () => MainScreen(),
      ),
    ],
  ));
}
