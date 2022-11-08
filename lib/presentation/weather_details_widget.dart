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
        locationListController.setCurrentCity(cityList[index].cityName);
      },
      itemBuilder: (context, index) {
        return Obx(() => Container(
          padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: getColorForMain(
                //     weatherContoller.getWeatherItem().value.main)),
                gradient: LinearGradient(colors: [
                  getGradientStartColorForMain(
                      weatherContoller.getWeatherItem().value.main),
                  getGradientEndColorForMain(
                      weatherContoller.getWeatherItem().value.main)
                ]),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          weatherContoller.cityItem.value?.cityName ?? '',
                          style: TextStyle(
                              color: getTextColorForMain(
                                  weatherContoller.getWeatherItem().value.main),
                              fontSize: 36),
                        ),
                      ),
                      Obx(() => weatherContoller
                              .getWeatherItem()
                              .value
                              .icon
                              .isEmpty
                          ? SizedBox()
                          : Image.network(
                              'http://openweathermap.org/img/wn/${weatherContoller.getWeatherItem().value.icon}.png',
                              width: MediaQuery.of(context).size.width * 0.10,
                              height: MediaQuery.of(context).size.width * 0.10,

                              // color: Colors.white,
                            )),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    child: Icon(
                                      Icons.thermostat,
                                      color: getTextColorForMain(
                                          weatherContoller
                                              .getWeatherItem()
                                              .value
                                              .main),
                                    ),
                                    padding: EdgeInsets.all(4),
                                  ),
                                  Text(
                                    "min temp : ${weatherContoller.getWeatherItem().value.tempMin}°",
                                    style: TextStyle(
                                        color: getTextColorForMain(
                                            weatherContoller
                                                .getWeatherItem()
                                                .value
                                                .main)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      color: getTextColorForMain(
                                          weatherContoller
                                              .getWeatherItem()
                                              .value
                                              .main),
                                    ),
                                    padding: EdgeInsets.all(4),
                                  ),
                                  Text(
                                    "max temp : ${weatherContoller.getWeatherItem().value.tempMax}°",
                                    style: TextStyle(
                                        color: getTextColorForMain(
                                            weatherContoller
                                                .getWeatherItem()
                                                .value
                                                .main)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: getTextColorForMain(
                                          weatherContoller
                                              .getWeatherItem()
                                              .value
                                              .main),
                                    ),
                                    padding: EdgeInsets.all(4),
                                  ),
                                  Text(
                                    "Feels like : ${weatherContoller.getWeatherItem().value.feelsLike}°",
                                    style: TextStyle(
                                        color: getTextColorForMain(
                                            weatherContoller
                                                .getWeatherItem()
                                                .value
                                                .main)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${weatherContoller.getWeatherItem().value.temp}°',
                                    style: TextStyle(
                                        color: getTextColorForMain(
                                            weatherContoller
                                                .getWeatherItem()
                                                .value
                                                .main),
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
                                    child: Icon(
                                      Icons.atm,
                                      color: getTextColorForMain(
                                          weatherContoller
                                              .getWeatherItem()
                                              .value
                                              .main),
                                    ),
                                    padding: EdgeInsets.all(4),
                                  ),
                                  Text(
                                    "pressure : ${weatherContoller.getWeatherItem().value.pressure} hPa",
                                    style: TextStyle(
                                        color: getTextColorForMain(
                                            weatherContoller
                                                .getWeatherItem()
                                                .value
                                                .main)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    child: Icon(
                                      Icons.water_drop,
                                      color: getTextColorForMain(
                                          weatherContoller
                                              .getWeatherItem()
                                              .value
                                              .main),
                                    ),
                                    padding: EdgeInsets.all(4),
                                  ),
                                  Text(
                                    "Humidity : ${weatherContoller.getWeatherItem().value.humidity} %",
                                    style: TextStyle(
                                        color: getTextColorForMain(
                                            weatherContoller
                                                .getWeatherItem()
                                                .value
                                                .main)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Padding(
                                  //   child: Icon(Icons.cloud,
                                  //       color: Colors.white),
                                  //   padding: EdgeInsets.all(4),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Main : ${weatherContoller.getWeatherItem().value.main}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: getTextColorForMain(
                                              weatherContoller
                                                  .getWeatherItem()
                                                  .value
                                                  .main)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              imageForMain(
                                weatherContoller.getWeatherItem().value.main,
                                height: 128,
                                width: 128,
                                color: getTextColorForMain(weatherContoller
                                    .getWeatherItem()
                                    .value
                                    .main),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  Color getColorForMain(String main) {
    Color color = Colors.grey;
    switch (main.toLowerCase()) {
      case 'rain':
        color = Colors.black54;
        break;
      case 'sunny':
        color = Colors.orange;
        break;
      case 'clouds':
        color = Colors.lightBlue;
        break;
      case 'clear':
        color = Color.fromRGBO(138, 226, 255, 1.0);
        break;
      case 'snow':
        color = Color.fromRGBO(224, 224, 224, 1.0);
        break;
    }
    return color;
  }

  Color getGradientStartColorForMain(String main) {
    Color color = Color.fromRGBO(229, 229, 229, 1.0);
    switch (main.toLowerCase()) {
      case 'rain':
        color = Color.fromRGBO(66, 84, 206, 1.0);
        break;
      case 'sunny':
        color = Color.fromRGBO(255, 179, 68, 1.0);
        break;
      case 'clouds':
        color = Color.fromRGBO(64, 192, 255, 1.0);
        break;
      case 'clear':
        color = Color.fromRGBO(164, 71, 183, 1.0);
        break;
      case 'snow':
        color = Color.fromRGBO(224, 224, 224, 1.0);
        break;
    }
    return color;
  }

  Color getGradientEndColorForMain(String main) {
    Color color = Colors.grey;
    switch (main.toLowerCase()) {
      case 'rain':
        color = Color.fromRGBO(9, 22, 152, 1.0);
        break;
      case 'sunny':
        color = Colors.orange;
        break;
      case 'clouds':
        color = Colors.lightBlue;
        break;
      case 'clear':
        color = Color.fromRGBO(127, 23, 157, 1.0);
        break;
      case 'snow':
        color = Color.fromRGBO(201, 201, 201, 1.0);
        break;
    }
    return color;
  }

  Color getTextColorForMain(String main) {
    Color color = Colors.white;
    switch (main.toLowerCase()) {
      case 'snow':
        color = Colors.black54;
        break;
    }
    return color;
  }

  Image imageForMain(String main,
      {required double height, required double width, required Color color}) {
    String asset = 'images/sunny.png';
    switch (main.toLowerCase()) {
      case 'rain':
        asset = 'images/sunny.png';
        break;
      case 'sunny':
        asset = 'images/sunny.png';
        break;
      case 'clouds':
        asset = 'images/sunny.png';
        break;
      case 'clear':
        asset = 'images/sunny.png';
        break;
      case 'snow':
        asset = 'images/sunny.png';
        break;
    }
    return Image.asset(
      asset,
      height: height,
      width: width,
      color: color,
    );
  }
}
