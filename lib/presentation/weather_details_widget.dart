import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final weatherContoller = Get.find<WeatherController>();
  final locationController = Get.find<GeoLocationController>();

  @override
  Widget build(BuildContext context) {
    weatherContoller.getWeather();
    return Obx(
      () => weatherContoller.checkLoading().isTrue
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(24),
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
                        () => Text(locationController.getCity().value,
                            style: TextStyle(
                                color: Color.fromARGB(255, 56, 89, 211))),
                      ),
                      Image.network(
                        'http://openweathermap.org/img/wn/${weatherContoller.getIcon()}.png',
                        width: 72,
                        height: 72,
                        fit: BoxFit.contain,
                        color: Color.fromARGB(255, 56, 89, 211),
                      ),
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
            ),
    );
  }
}
