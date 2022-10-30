import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';
import 'package:weather/presentation/header_widget.dart';
import 'package:weather/presentation/weather_details_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final GeoLocationController locationController =
      Get.find<GeoLocationController>();
  final WeatherController weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => (locationController.checkLoading().isTrue)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      HeaderWidget(),
                      WeatherDetailsWidget(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
