import 'package:flutter/material.dart';
import 'package:weather/presentation/controller/weather_controller.dart';
import 'package:get/get.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final weatherContoller = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    weatherContoller.getWeather();
    return Obx(() =>

    weatherContoller
        .checkLoading()
        .isTrue ?
    Center(child: CircularProgressIndicator()) :
    Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.lightBlue
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.thermostat),
              Text("temp : " + weatherContoller
                  .getTemp()
                  .string)
            ],
          ),
          Row(
            children: [
              Icon(Icons.thermostat),
              Text("min temp : " + weatherContoller
                  .getTempMin()
                  .string),
            ],
          ),
          Row(
            children: [
              Icon(Icons.thermostat),
              Text("max temp : " + weatherContoller
                  .getTempMax()
                  .string),],
          ),
          Row(
            children: [
              Icon(Icons.thermostat),
              Text("Feels like : " + weatherContoller
                  .getFeelsLike()
                  .string),
            ],
          ),
          Row(
            children: [
              Icon(Icons.atm),
              Text("pressure : " + weatherContoller
                  .getPressure()
                  .string),
            ],
          ),
          Row(
            children: [
              Icon(Icons.water_drop),
              Text("Humidity : " + weatherContoller
                  .getHumidity()
                  .string),
            ],
          ),
        ],
      ),
    ),);
  }

}