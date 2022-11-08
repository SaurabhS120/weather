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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black38, Colors.black54],
                begin: Alignment(0, -1),
                end: Alignment(0, 1))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: locationListController.getCityList().length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.25098039215686274),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locationListController
                                .getCityList()[index]
                                .cityName,
                            style: TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                locationListController.remove(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/location');
                  },
                  child: Text('Add city'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black54),
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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
