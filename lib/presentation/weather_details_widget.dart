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
                gradient: LinearGradient(
                  colors: [
                    getGradientStartColorForMain(
                        weatherContoller.getWeatherItem().value.main),
                    getGradientEndColorForMain(
                        weatherContoller.getWeatherItem().value.main)
                  ],
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                ),
              ),
              child: Column(
                children: [
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
                              SizedBox(
                                height: 24,
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    Text(
                                      weatherContoller
                                              .cityItem.value?.cityName ??
                                          '',
                                      style: TextStyle(
                                          color: getTextColorForMain(
                                              weatherContoller
                                                  .getWeatherItem()
                                                  .value
                                                  .main),
                                          fontSize: 36),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${weatherContoller.getWeatherItem().value.temp.toInt()}°',
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
                              Row(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
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
                                        "${weatherContoller.getWeatherItem().value.tempMax}°",
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
                                    mainAxisSize: MainAxisSize.min,
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
                                        "${weatherContoller.getWeatherItem().value.tempMin}°",
                                        style: TextStyle(
                                            color: getTextColorForMain(
                                                weatherContoller
                                                    .getWeatherItem()
                                                    .value
                                                    .main)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${weatherContoller.getWeatherItem().value.main}",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: getTextColorForMain(
                                                  weatherContoller
                                                      .getWeatherItem()
                                                      .value
                                                      .main)),
                                        ),
                                        Text(
                                          "Feels like : ${weatherContoller.getWeatherItem().value.feelsLike}",
                                          style: TextStyle(
                                              color: getTextColorForMain(
                                                  weatherContoller
                                                      .getWeatherItem()
                                                      .value
                                                      .main)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
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
                  ),
                  Divider(
                    color: getTextColorForMain(
                        weatherContoller.getWeatherItem().value.main),
                  ),
                  SizedBox(
                    height: 64,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: weatherContoller
                          .getHourlyWeatherItem()
                          .value
                          .data
                          .length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            imageForMain(
                                weatherContoller
                                    .getHourlyWeatherItem()
                                    .value
                                    .data[index]
                                    .main,
                                height: 24,
                                width: 24,
                                color: getTextColorForMain(weatherContoller
                                    .getWeatherItem()
                                    .value
                                    .main)),
                            Text(
                              weatherContoller
                                  .getHourlyWeatherItem()
                                  .value
                                  .data[index]
                                  .temp
                                  .toString(),
                              style: TextStyle(
                                  color: getTextColorForMain(weatherContoller
                                      .getWeatherItem()
                                      .value
                                      .main)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: getTextColorForMain(
                        weatherContoller.getWeatherItem().value.main),
                  ),
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
        color = Color.fromRGBO(243, 165, 61, 1.0);
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
        color = Color.fromRGBO(255, 140, 41, 1.0);
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
        asset = 'images/rain.png';
        break;
      case 'sunny':
        asset = 'images/sunny.png';
        break;
      case 'clouds':
        asset = 'images/cloud.png';
        break;
      case 'clear':
        asset = 'images/sunny.png';
        break;
      case 'snow':
        asset = 'images/snow.png';
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
