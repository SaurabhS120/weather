import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/binding/main_binding.dart';
import 'package:weather/presentation/weather_details_widget.dart';

import 'presentation/location_list_screen.dart';
import 'presentation/location_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Provider(
    create: (context) => MainBinding.createBinding(),
    child: MaterialApp(
      initialRoute: '/location_list',
      routes: {
        '/location': (context) => LocationScreen(),
        '/location_list': (context) => LocationListScreen(),
        '/home': (context) => WeatherDetailsWidget(),
      },
    ),
  ));
}
