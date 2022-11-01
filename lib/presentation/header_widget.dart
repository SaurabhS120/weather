import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class HeaderWidget extends StatelessWidget {
  final weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          child: Obx(
              () => Text(weatherController.cityEntity.value?.cityName ?? '')),
        ),
      ],
    );
  }
}
