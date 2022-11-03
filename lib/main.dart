import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'di/binding/location_list_binding.dart';
import 'di/binding/location_screen_binding.dart';
import 'di/binding/weather_details_binding.dart';
import 'presentation/location_list_screen.dart';
import 'presentation/location_screen.dart';
import 'presentation/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    initialRoute: '/location_list',
    initialBinding: LocationListBinding(),
    getPages: [
      GetPage(
        name: '/location',
        page: () => LocationScreen(),
        binding: LocationScreenBinding(),
      ),
      GetPage(
        name: '/location_list',
        page: () => LocationListScreen(),
        binding: LocationListBinding(),
      ),
      GetPage(
        name: '/home',
        page: () => MainScreen(),
        binding: WeatherDetailsBinding(),
      ),
    ],
  ));
}
