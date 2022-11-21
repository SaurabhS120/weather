import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/binding/main_binding.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
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
  LocationNotifier locationNotifier = LocationNotifier();
  WeatherNotifier weatherNotifier = WeatherNotifier(
      mainBinding.citiesLocalUseCase,
      mainBinding.weatherDataUsecase,
      mainBinding.hourlyWeatherDataUseCase);
  GeoLocationController geoLocationController = GeoLocationController(
      mainBinding.locationFromCityUsecase,
      mainBinding.latLongToCityNameUsecase,
      mainBinding.locationUseCase,
      locationNotifier);
  runApp(MultiProvider(
    providers: [
      Provider.value(value: mainBinding),
      Provider.value(
        value: AssetsProvider(),
      ),
      Provider.value(
        value: geoLocationController,
      ),
      Provider.value(
        value: GeoLocationController(
            mainBinding.locationFromCityUsecase,
            mainBinding.latLongToCityNameUsecase,
            mainBinding.locationUseCase,
            locationNotifier),
      ),
      ChangeNotifierProvider.value(value: UiConfigNotifier()),
      ChangeNotifierProvider.value(value: weatherNotifier),
      ChangeNotifierProvider.value(value: locationNotifier),
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
