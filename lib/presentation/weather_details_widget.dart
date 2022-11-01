import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final locationController = Get.find<GeoLocationController>();
  final locationListController = Get.find<LocationListController>();

  @override
  Widget build(BuildContext context) {
    final cityList = locationListController.getCityList();
    final weatherContoller = WeatherController();
    weatherContoller.set(cityList[0]);
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cityList.length,
      onPageChanged: (index) {
        weatherContoller.set(cityList[index]);
      },
      itemBuilder: (context, index) {
        return Obx(() => Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(155, 212, 248, 1.0), Colors.blue],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                            weatherContoller.cityEntity.value?.cityName ?? '',
                            style: TextStyle(
                                color: Color.fromARGB(255, 56, 89, 211))),
                      ),
                      Obx(() => weatherContoller.getIcon().value.isEmpty
                          ? SizedBox()
                          : Image.network(
                              'http://openweathermap.org/img/wn/${weatherContoller.getIcon().value}.png',
                              width: MediaQuery.of(context).size.width * 0.10,
                              height: MediaQuery.of(context).size.width * 0.10,

                              // color: Color.fromARGB(255, 56, 89, 211),
                            )),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weatherContoller.getTemp().string + '°',
                        style: TextStyle(
                            color: Color.fromARGB(255, 56, 89, 211),
                            fontSize: 72),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Padding(
                        child: Icon(Icons.thermostat,
                            color: Color.fromARGB(255, 56, 89, 211)),
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        "min temp : " +
                            weatherContoller.getTempMin().string +
                            '°',
                        style:
                            TextStyle(color: Color.fromARGB(255, 56, 89, 211)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        child: Icon(Icons.thermostat,
                            color: Color.fromARGB(255, 56, 89, 211)),
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        "max temp : " +
                            weatherContoller.getTempMax().string +
                            '°',
                        style:
                            TextStyle(color: Color.fromARGB(255, 56, 89, 211)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        child: Icon(Icons.thermostat,
                            color: Color.fromARGB(255, 56, 89, 211)),
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        "Feels like : " +
                            weatherContoller.getFeelsLike().string +
                            '°',
                        style:
                            TextStyle(color: Color.fromARGB(255, 56, 89, 211)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        child: Icon(Icons.atm,
                            color: Color.fromARGB(255, 56, 89, 211)),
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        "pressure : " +
                            weatherContoller.getPressure().string +
                            ' hPa',
                        style:
                            TextStyle(color: Color.fromARGB(255, 56, 89, 211)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        child: Icon(Icons.water_drop,
                            color: Color.fromARGB(255, 56, 89, 211)),
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        "Humidity : " +
                            weatherContoller.getHumidity().string +
                            ' %',
                        style:
                            TextStyle(color: Color.fromARGB(255, 56, 89, 211)),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
