import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';
import 'package:weather/presentation/notifiers/location_list_notifier.dart';

class LocationListScreen extends StatelessWidget {
  final locationListController = Get.find<LocationListController>();
  final GeoLocationController locationController =
      Get.find<GeoLocationController>();
  final WeatherController weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    locationListController.updateData();
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(100, 100, 100, 1.0),
          Color.fromRGBO(0, 0, 0, 1)
        ], begin: Alignment(0, -1), end: Alignment(0, 1))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColoredBox(
              color: Color.fromRGBO(0, 0, 0, 0.7490196078431373),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => null,
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    Text(
                      'City list',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    TextButton(
                        onPressed: () => Get.toNamed('/location'),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(child: LocationListWidget()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (locationListController.getCityList().isEmpty) {
                      Get.snackbar("No locations",
                          'Please add atleast one location to proceed');
                    } else {
                      locationController
                          .setLocation(locationListController.getCityList()[0]);
                      weatherController
                          .set(locationListController.getCityList()[0]);
                      Get.toNamed('/home');
                    }
                  },
                  child: Text('Proceed'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.2)),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class LocationListWidget extends StatefulWidget {
  @override
  State<LocationListWidget> createState() => _LocationListWidgetState();
}

class _LocationListWidgetState extends State<LocationListWidget> {
  final locationListController = Get.find<LocationListController>();
  final GeoLocationController locationController =
      Get.find<GeoLocationController>();
  final WeatherController weatherController = Get.find<WeatherController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => locationListController.locationNotifier,
        child: Consumer<LocationListNotifier>(
          builder: (context, value, child) => GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: (value.weather_item.length < value.city_list.length)
                ? value.weather_item.length
                : value.city_list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () => locationListController.remove(index),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              locationListController
                                  .locationNotifier.city_list[index].cityName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              locationListController
                                  .locationNotifier.weather_item[index].main,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  locationListController.remove(index),
                            ),
                            weatherController.imageForMain(
                                locationListController
                                    .locationNotifier.weather_item[index].main,
                                height: 24,
                                width: 24,
                                color: Colors.white),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "${value.weather_item[index].temp}°",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
