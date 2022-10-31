import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class LocationListScreen extends StatelessWidget {
  final location_list_controller = Get.find<LocationListController>();
  final GeoLocationController locationController =
      Get.find<GeoLocationController>();
  final WeatherController weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Location list'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: location_list_controller.getCityList().length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      location_list_controller.getCityList()[index].city_name),
                );
              },
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/location');
                },
                child: Text('Add city'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (location_list_controller.getCityList().isEmpty) {
                    Get.snackbar("No locations",
                        'Please add atleast one location to proceed');
                  } else {
                    locationController
                        .setLocation(location_list_controller.getCityList()[0]);
                    weatherController
                        .set(location_list_controller.getCityList()[0]);
                    Get.offNamed('/home');
                  }
                },
                child: Text('Proceed'),
              ),
            ],
          )
        ],
          ),
        ));
  }
}
