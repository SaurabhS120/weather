import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'di/di.dart';
import 'presentation/location_list_screen.dart';
import 'presentation/location_screen.dart';
import 'presentation/main_screen.dart';

void main() {
  DI.injectAll();
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
