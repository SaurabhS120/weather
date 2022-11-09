import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/weather_details_widget.dart';

import 'di/binding/main_binding.dart';
import 'presentation/location_list_screen.dart';
import 'presentation/location_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    initialRoute: '/location_list',
    initialBinding: MainBinding(),
    getPages: [
      GetPage(
        name: '/location',
        page: () => LocationScreen(),
        // binding: LocationScreenBinding(),
      ),
      GetPage(
        name: '/location_list',
        page: () => LocationListScreen(),
        // binding: LocationListBinding(),
      ),
      GetPage(
        name: '/home',
        page: () => WeatherDetailsWidget(),
        // binding: WeatherDetailsBinding(),
      ),
    ],
  ));
}
