import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class LocationListScreen extends StatelessWidget {
  final locationListController = Get.find<LocationListController>();
  final GeoLocationController locationController =
      Get.find<GeoLocationController>();
  final WeatherController weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    locationListController.getFromDB();
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
                  itemCount: locationListController.getCityList().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                      locationListController.getCityList()[index].cityName),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => locationListController.remove(index),
                  ),
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
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
