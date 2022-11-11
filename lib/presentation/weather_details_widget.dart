import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';
import 'package:weather/presentation/notifiers/weather_notifier.dart';

class WeatherDetailsWidget extends StatefulWidget {
  @override
  State<WeatherDetailsWidget> createState() => _WeatherDetailsWidgetState();
}

class _WeatherDetailsWidgetState extends State<WeatherDetailsWidget> {
  final locationListController = Get.find<LocationListController>();
  final weatherContoller = Get.find<WeatherController>();

  @override
  void init() {
    weatherContoller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final cityList = locationListController.getCityList();
    weatherContoller.init();
    weatherContoller.set(cityList[0]);
    return SafeArea(
      child: Scaffold(
          body: ChangeNotifierProvider(
        builder: (context, child) => Consumer<WeatherNotifier>(
            builder: (context, weather, child) => Container(
                  decoration: BoxDecoration(
                    // color: getColorForMain(
                    //     weather.weatherItem.main)),
                    gradient: LinearGradient(
                      colors: [
                        weatherContoller.getGradientStartColorForMain(
                            weather.weatherItem.main),
                        weatherContoller.getGradientEndColorForMain(
                            weather.weatherItem.main)
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
                                    weather.weatherItem.main,
                                  ),
                                ),
                              ),
                              Text(
                                "${weather.weatherItem.date}",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: weatherContoller.getTextColorForMain(
                                    weather.weatherItem.main,
                                  ),
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  weather.unit.unit.displayText(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: weatherContoller.getTextColorForMain(
                                        weather.weatherItem.main),
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
                            return Column(
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
                                            Row(
                                              children: [
                                                Text(
                                                  weather.cityItem?.cityName ??
                                                      '',
                                                  style: TextStyle(
                                                      color: weatherContoller
                                                          .getTextColorForMain(
                                                              weather
                                                                  .weatherItem
                                                                  .main),
                                                      fontSize: 36),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 24,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${weather.weatherItem.temp.toInt()}°',
                                                  style: TextStyle(
                                                      color: weatherContoller
                                                          .getTextColorForMain(
                                                              weather
                                                                  .weatherItem
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
                                                                weather
                                                                    .weatherItem
                                                                    .main),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                    ),
                                                    Text(
                                                      "${weather.weatherItem.tempMax}°",
                                                      style: TextStyle(
                                                          color: weatherContoller
                                                              .getTextColorForMain(
                                                                  weather
                                                                      .weatherItem
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
                                                                weather
                                                                    .weatherItem
                                                                    .main),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                    ),
                                                    Text(
                                                      "${weather.weatherItem.tempMin}°",
                                                      style: TextStyle(
                                                          color: weatherContoller
                                                              .getTextColorForMain(
                                                                  weather
                                                                      .weatherItem
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
                                                        "${weather.weatherItem.main}",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: weatherContoller
                                                                .getTextColorForMain(
                                                                    weather
                                                                        .weatherItem
                                                                        .main)),
                                                      ),
                                                      Text(
                                                        "Feels like : ${weather.weatherItem.feelsLike}°",
                                                        style: TextStyle(
                                                            color: weatherContoller
                                                                .getTextColorForMain(
                                                                    weather
                                                                        .weatherItem
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
                                            WeatherImageWidget(
                                                pageIndex,
                                                weatherContoller
                                                    .getTextColorForMain(weather
                                                        .weatherItem.main)),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: weatherContoller.getTextColorForMain(
                                      weather.weatherItem.main),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        weather.hourlyWeatherItem.data.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            weather.hourlyWeatherItem
                                                .data[index].time,
                                            style: TextStyle(
                                                color: weatherContoller
                                                    .getTextColorForMain(weather
                                                        .weatherItem.main)),
                                          ),
                                          weatherContoller.imageForMain(
                                              weather.hourlyWeatherItem
                                                  .data[pageIndex].main,
                                              height: 24,
                                              width: 24,
                                              color: weatherContoller
                                                  .getTextColorForMain(weather
                                                      .weatherItem.main)),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "${weather.hourlyWeatherItem.data[index].temp}°",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: weatherContoller
                                                      .getTextColorForMain(
                                                          weather.weatherItem
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
                                      weather.weatherItem.main),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )),
        create: (BuildContext context) => weatherContoller.weather_notifier,
      )),
    );
  }
}

class WeatherImageWidget extends StatefulWidget {
  int pageIndex;
  Color color;

  WeatherImageWidget(this.pageIndex, this.color);

  @override
  State<StatefulWidget> createState() =>
      WeatherImageWidgetState(this.pageIndex, this.color);
}

class WeatherImageWidgetState extends State<WeatherImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final locationListController = Get.find<LocationListController>();
  final weatherContoller = Get.find<WeatherController>();
  int pageIndex;
  Color color;

  WeatherImageWidgetState(this.pageIndex, this.color);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: weatherContoller.imageForMain(
          locationListController.getWeatherList().value[pageIndex].main,
          height: 128,
          width: 128,
          color: color,
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
    animationController.dispose();
    super.dispose();
  }

}