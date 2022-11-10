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
    final weatherContoller = Get.find<WeatherController>();
    weatherContoller.set(cityList[0]);
    return SafeArea(
      child: Scaffold(
        body: Obx(() => Container(
              decoration: BoxDecoration(
                // color: getColorForMain(
                //     weatherContoller.getWeatherItem().value.main)),
                gradient: LinearGradient(
                  colors: [
                    weatherContoller.getGradientStartColorForMain(
                        weatherContoller.getWeatherItem().value.main),
                    weatherContoller.getGradientEndColorForMain(
                        weatherContoller.getWeatherItem().value.main)
                  ],
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                ),
              ),
              child: Column(
                children: [
                  ColoredBox(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Icon(
                              Icons.menu,
                              size: 24,
                              color: weatherContoller.getTextColorForMain(
                                weatherContoller.getWeatherItem().value.main,
                              ),
                            ),
                          ),
                          Text(
                            "${weatherContoller.getWeatherItem().value.date}",
                            style: TextStyle(
                              fontSize: 24,
                              color: weatherContoller.getTextColorForMain(
                                weatherContoller.getWeatherItem().value.main,
                              ),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              weatherContoller.unit.value.unit.displayText(),
                              style: TextStyle(
                                fontSize: 24,
                                color: weatherContoller.getTextColorForMain(
                                    weatherContoller
                                        .getWeatherItem()
                                        .value
                                        .main),
                              ),
                            ),
                            onPressed: () => weatherContoller.toggleUnit(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cityList.length,
                      onPageChanged: (pageIndex) {
                        weatherContoller.set(cityList[pageIndex]);
                        locationListController
                            .setCurrentCity(cityList[pageIndex].cityName);
                      },
                      itemBuilder: (context, pageIndex) {
                        return Obx(() => Column(
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
                                                    weatherContoller.cityItem
                                                            .value?.cityName ??
                                                        '',
                                                    style: TextStyle(
                                                        color: weatherContoller
                                                            .getTextColorForMain(
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
                                                      color: weatherContoller
                                                          .getTextColorForMain(
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      child: Icon(
                                                        Icons.keyboard_arrow_up,
                                                        color: weatherContoller
                                                            .getTextColorForMain(
                                                                weatherContoller
                                                                    .getWeatherItem()
                                                                    .value
                                                                    .main),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                    ),
                                                    Text(
                                                      "${weatherContoller.getWeatherItem().value.tempMax}°",
                                                      style: TextStyle(
                                                          color: weatherContoller
                                                              .getTextColorForMain(
                                                                  weatherContoller
                                                                      .getWeatherItem()
                                                                      .value
                                                                      .main)),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: weatherContoller
                                                            .getTextColorForMain(
                                                                weatherContoller
                                                                    .getWeatherItem()
                                                                    .value
                                                                    .main),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                    ),
                                                    Text(
                                                      "${weatherContoller.getWeatherItem().value.tempMin}°",
                                                      style: TextStyle(
                                                          color: weatherContoller
                                                              .getTextColorForMain(
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${weatherContoller.getWeatherItem().value.main}",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: weatherContoller
                                                                .getTextColorForMain(
                                                                    weatherContoller
                                                                        .getWeatherItem()
                                                                        .value
                                                                        .main)),
                                                      ),
                                                      Text(
                                                        "Feels like : ${weatherContoller.getWeatherItem().value.feelsLike}°",
                                                        style: TextStyle(
                                                            color: weatherContoller
                                                                .getTextColorForMain(
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
                                            WeatherImageWidget(pageIndex),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: weatherContoller.getTextColorForMain(
                                      weatherContoller
                                          .getWeatherItem()
                                          .value
                                          .main),
                                ),
                                SizedBox(
                                  height: 80,
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
                                          Text(
                                            weatherContoller
                                                .getHourlyWeatherItem()
                                                .value
                                                .data[index]
                                                .time,
                                            style: TextStyle(
                                                color: weatherContoller
                                                    .getTextColorForMain(
                                                        weatherContoller
                                                            .getWeatherItem()
                                                            .value
                                                            .main)),
                                          ),
                                          weatherContoller.imageForMain(
                                              weatherContoller
                                                  .getHourlyWeatherItem()
                                                  .value
                                                  .data[pageIndex]
                                                  .main,
                                              height: 24,
                                              width: 24,
                                              color: weatherContoller
                                                  .getTextColorForMain(
                                                      weatherContoller
                                                          .getWeatherItem()
                                                          .value
                                                          .main)),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "${weatherContoller.getHourlyWeatherItem().value.data[index].temp}°",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: weatherContoller
                                                      .getTextColorForMain(
                                                          weatherContoller
                                                              .getWeatherItem()
                                                              .value
                                                              .main)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: weatherContoller.getTextColorForMain(
                                      weatherContoller
                                          .getWeatherItem()
                                          .value
                                          .main),
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class WeatherImageWidget extends StatefulWidget {
  int pageIndex;

  WeatherImageWidget(this.pageIndex);

  @override
  State<StatefulWidget> createState() =>
      WeatherImageWidgetState(this.pageIndex);
}

class WeatherImageWidgetState extends State<WeatherImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final locationController = Get.find<GeoLocationController>();
  final locationListController = Get.find<LocationListController>();
  final weatherContoller = Get.find<WeatherController>();
  int pageIndex;

  WeatherImageWidgetState(this.pageIndex);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: weatherContoller.imageForMain(
          locationListController.getWeatherList().value[pageIndex].main,
          height: 128,
          width: 128,
          color: weatherContoller.getTextColorForMain(
              weatherContoller.getWeatherItem().value.main),
        ),
      );

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        upperBound: 1,
        lowerBound: 0.7);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

}