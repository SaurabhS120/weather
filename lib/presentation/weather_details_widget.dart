import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/binding/main_binding.dart';
import 'package:weather/presentation/notifiers/weather_notifier.dart';

class WeatherDetailsWidget extends StatefulWidget {
  @override
  State<WeatherDetailsWidget> createState() => _WeatherDetailsWidgetState();
}

class _WeatherDetailsWidgetState extends State<WeatherDetailsWidget> {
  late MainBinding mainBinding;

  // @override
  // void init() {
  //   mainBinding = Provider.of<MainBinding>(context);
  //   mainBinding.weatherController.addListener(() {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    mainBinding = Provider.of<MainBinding>(context);
    mainBinding.weatherController.addListener(() {
      setState(() {});
    });
    final cityList = mainBinding.locationListController.getCityList();
    mainBinding.weatherController.init();
    mainBinding.weatherController.set(cityList[0]);
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
                        mainBinding.weatherController
                            .getGradientStartColorForMain(
                                weather.weatherItem.main),
                                mainBinding.weatherController
                            .getGradientEndColorForMain(
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
                                  color: mainBinding.weatherController
                                      .getTextColorForMain(
                                    weather.weatherItem.main,
                                  ),
                                ),
                              ),
                              Text(
                                "${weather.weatherItem.date}",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: mainBinding.weatherController
                                      .getTextColorForMain(
                                    weather.weatherItem.main,
                                  ),
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  weather.unit.unit.displayText(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: mainBinding.weatherController
                                        .getTextColorForMain(
                                            weather.weatherItem.main),
                                  ),
                                ),
                                onPressed: () =>
                                    mainBinding.weatherController.toggleUnit(),
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
                            mainBinding.weatherController
                                .set(cityList[pageIndex]);
                            mainBinding.locationListController
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
                                                      color: mainBinding
                                                          .weatherController
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
                                                      color: mainBinding
                                                          .weatherController
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
                                                        color: mainBinding
                                                            .weatherController
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
                                                          color: mainBinding
                                                              .weatherController
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
                                                        color: mainBinding
                                                            .weatherController
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
                                                          color: mainBinding
                                                              .weatherController
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
                                                            color: mainBinding
                                                                .weatherController
                                                                .getTextColorForMain(
                                                                    weather
                                                                        .weatherItem
                                                                        .main)),
                                                      ),
                                                      Text(
                                                        "Feels like : ${weather.weatherItem.feelsLike}°",
                                                        style: TextStyle(
                                                            color: mainBinding
                                                                .weatherController
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
                                                mainBinding.weatherController
                                                    .getTextColorForMain(weather
                                                        .weatherItem.main)),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: mainBinding.weatherController
                                      .getTextColorForMain(
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
                                                color: mainBinding
                                                    .weatherController
                                                    .getTextColorForMain(weather
                                                        .weatherItem.main)),
                                          ),
                                          mainBinding.weatherController
                                              .imageForMain(
                                                  weather.hourlyWeatherItem
                                                      .data[pageIndex].main,
                                                  height: 24,
                                                  width: 24,
                                                  color: mainBinding
                                                      .weatherController
                                                      .getTextColorForMain(
                                                          weather.weatherItem
                                                              .main)),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "${weather.hourlyWeatherItem.data[index].temp}°",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: mainBinding
                                                      .weatherController
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
                                  color: mainBinding.weatherController
                                      .getTextColorForMain(
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
        create: (BuildContext context) =>
            mainBinding.weatherController.weather_notifier,
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
  late MainBinding mainBinding;
  int pageIndex;
  Color color;

  WeatherImageWidgetState(this.pageIndex, this.color);

  @override
  Widget build(BuildContext context) {
    mainBinding = Provider.of<MainBinding>(context);
    return ScaleTransition(
      scale: animation,
      child: mainBinding.weatherController.imageForMain(
        mainBinding.locationListController
            .getWeatherList()
            .value[pageIndex]
            .main,
        height: 128,
        width: 128,
        color: color,
      ),
    );
  }

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