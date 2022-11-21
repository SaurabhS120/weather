import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/binding/main_binding.dart';
import 'package:weather/presentation/notifiers/location_notifier.dart';
import 'package:weather/presentation/notifiers/ui_config_notifier.dart';
import 'package:weather/presentation/notifiers/weather_notifier.dart';
import 'package:weather/presentation/provider/assets_provider.dart';
import 'package:weather/presentation/weather_details_widget.dart';

import 'presentation/location_list_screen.dart';
import 'presentation/location_screen.dart';
import 'presentation/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MainBinding mainBinding = MainBinding.createBinding();
  runApp(MultiProvider(
    providers: [
      Provider.value(value: mainBinding),
      Provider.value(
        value: AssetsProvider(),
      ),
      ChangeNotifierProvider.value(value: UiConfigNotifier()),
      ChangeNotifierProvider.value(value: WeatherNotifier(mainBinding)),
      ChangeNotifierProvider.value(value: LocationNotifier(mainBinding)),
    ],
    child: MaterialApp(
      initialRoute: '/location_list',
      routes: {
        '/location': (context) => LocationScreen(),
        '/location_list': (context) => LocationListScreen(),
        '/home': (context) => WeatherDetailsWidget(),
      },
      navigatorKey: NavigationService.navigatorKey,
    ),
  ));
}
