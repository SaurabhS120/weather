import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/binding/main_binding.dart';
import 'package:weather/presentation/notifiers/ui_config_notifier.dart';
import 'package:weather/presentation/notifiers/weather_notifier.dart';

class WeatherDetailsWidget extends StatefulWidget {
  @override
  State<WeatherDetailsWidget> createState() => _WeatherDetailsWidgetState();
}

class _WeatherDetailsWidgetState extends State<WeatherDetailsWidget> {
  late MainBinding mainBinding;

  @override
  Widget build(BuildContext context) {
    mainBinding = Provider.of<MainBinding>(context);
    mainBinding.locationListController.addListener(() {
      setState(() {});
    });
    mainBinding.locationListController.uiNotifier.setCurrentCity(mainBinding
            .locationListController
            .weatherNotifier
            .weathers[0]
            .cityItem
            ?.cityName ??
        '');
    return SafeArea(
        child: Scaffold(
      body: ChangeNotifierProvider.value(
          value: mainBinding.locationListController.weatherNotifier,
          builder: (context, child) => ChangeNotifierProvider.value(
                value: mainBinding.locationListController.uiNotifier,
                builder: (context, child) => Consumer<WeatherNotifier>(
                  builder: (context, weatherNotifier, child) => Consumer<
                          UiConfigNotifier>(
                      builder: (context, uiConfigNotifier, child) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  mainBinding.locationListController
                                      .getGradientStartColorForMain(
                                          weatherNotifier
                                                  .weathers[uiConfigNotifier
                                                      .current_page_no]
                                                  .weatherItem
                                                  ?.main ??
                                              ''),
                                  mainBinding.locationListController
                                      .getGradientEndColorForMain(
                                          weatherNotifier
                                                  .weathers[uiConfigNotifier
                                                      .current_page_no]
                                                  .weatherItem
                                                  ?.main ??
                                              '')
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
                                            color: mainBinding
                                                .locationListController
                                                .getTextColorForMain(
                                              weatherNotifier
                                                      .weathers[uiConfigNotifier
                                                          .current_page_no]
                                                      .weatherItem
                                                      ?.main ??
                                                  '',
                                            ),
                                          ),
                              ),
                              Text(
                                "${weatherNotifier.weathers[uiConfigNotifier.current_page_no].weatherItem?.date}",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: mainBinding
                                                .locationListController
                                                .getTextColorForMain(
                                              weatherNotifier
                                                      .weathers[uiConfigNotifier
                                                          .current_page_no]
                                                      .weatherItem
                                                      ?.main ??
                                                  '',
                                            ),
                                          ),
                                        ),
                              TextButton(
                                child: Text(
                                            weatherNotifier.unit.unit
                                                .displayText(),
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: mainBinding
                                                  .locationListController
                                                  .getTextColorForMain(weatherNotifier
                                                          .weathers[
                                                              uiConfigNotifier
                                                                  .current_page_no]
                                                          .weatherItem
                                                          ?.main ??
                                                      ''),
                                            ),
                                          ),
                                          onPressed: () => mainBinding
                                              .locationListController
                                              .toggleUnit(),
                                        ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                                    itemCount: weatherNotifier.weathers.length,
                                    onPageChanged: (pageIndex) {
                                      uiConfigNotifier.changePage(pageIndex);
                                      uiConfigNotifier.setCurrentCity(
                                          weatherNotifier.weathers[pageIndex]
                                                  .cityItem?.cityName ??
                                              '');
                                      mainBinding.locationListController
                                          .setCurrentCity(weatherNotifier
                                                  .weathers[pageIndex]
                                                  .cityItem
                                                  ?.cityName ??
                                              '');
                                    },
                                    itemBuilder: (context, pageIndex) {
                                      var weatherDetails =
                                          weatherNotifier.weathers[pageIndex];
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
                                                  weatherDetails
                                                                    .cityItem
                                                                    ?.cityName ??
                                                                '',
                                                  style: TextStyle(
                                                      color: mainBinding
                                                                    .locationListController
                                                                    .getTextColorForMain(weatherNotifier
                                                                            .weathers[pageIndex]
                                                                            .weatherItem
                                                                            ?.main ??
                                                                        ''),
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
                                                  '${weatherDetails.weatherItem?.temp.toInt()}°',
                                                            style: TextStyle(
                                                                color: mainBinding
                                                                    .locationListController
                                                                    .getTextColorForMain(
                                                                        weatherDetails.weatherItem?.main ??
                                                                            ''),
                                                                fontSize: 72),
                                                          )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Padding(
                                                                child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_up,
                                                                  color: mainBinding
                                                                      .locationListController
                                                                      .getTextColorForMain(
                                                                          weatherDetails.weatherItem?.main ??
                                                                              ''),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4),
                                                              ),
                                                    Text(
                                                      "${weatherDetails.weatherItem?.tempMax}°",
                                                                style: TextStyle(
                                                                    color: mainBinding
                                                                        .locationListController
                                                                        .getTextColorForMain(weatherDetails.weatherItem?.main ??
                                                                            '')),
                                                              ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Padding(
                                                                child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: mainBinding
                                                                      .locationListController
                                                                      .getTextColorForMain(
                                                                          weatherDetails.weatherItem?.main ??
                                                                              ''),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4),
                                                              ),
                                                    Text(
                                                      "${weatherDetails.weatherItem?.tempMin}°",
                                                                style: TextStyle(
                                                                    color: mainBinding
                                                                        .locationListController
                                                                        .getTextColorForMain(weatherDetails.weatherItem?.main ??
                                                                            '')),
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
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${weatherDetails.weatherItem?.main ?? ''}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      color: mainBinding
                                                                          .locationListController
                                                                          .getTextColorForMain(weatherDetails.weatherItem?.main ??
                                                                              '')),
                                                                ),
                                                                Text(
                                                                  "Feels like : ${weatherDetails.weatherItem?.feelsLike ?? ''}°",
                                                                  style: TextStyle(
                                                                      color: mainBinding
                                                                          .locationListController
                                                                          .getTextColorForMain(weatherDetails.weatherItem?.main ??
                                                                              '')),
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
                                                          mainBinding
                                                              .locationListController
                                                              .getTextColorForMain(
                                                                  weatherDetails
                                                                          .weatherItem
                                                                          ?.main ??
                                                                      '')),
                                                    ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                            color: mainBinding
                                                .locationListController
                                                .getTextColorForMain(
                                                    weatherDetails.weatherItem
                                                            ?.main ??
                                                        ''),
                                          ),
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: weatherDetails
                                                  .hourlyWeatherItem
                                                  ?.data
                                                  .length,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      weatherDetails
                                                              .hourlyWeatherItem
                                                              ?.data[index]
                                                              .time ??
                                                          '',
                                                      style: TextStyle(
                                                          color: mainBinding
                                                              .locationListController
                                                              .getTextColorForMain(
                                                                  weatherDetails
                                                                          .weatherItem
                                                                          ?.main ??
                                                                      '')),
                                                    ),
                                                    mainBinding.locationListController.imageForMain(
                                                        weatherDetails
                                                                .hourlyWeatherItem
                                                                ?.data[
                                                                    pageIndex]
                                                                .main ??
                                                            '',
                                                        height: 24,
                                                        width: 24,
                                                        color: mainBinding
                                                            .locationListController
                                                            .getTextColorForMain(
                                                                weatherDetails
                                                                        .weatherItem
                                                                        ?.main ??
                                                                    '')),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "${weatherDetails.hourlyWeatherItem?.data[index].temp}°",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: mainBinding
                                                                .locationListController
                                                                .getTextColorForMain(
                                                                    weatherDetails
                                                                            .weatherItem
                                                                            ?.main ??
                                                                        '')),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ),
                                ),
                                Divider(
                                            color: mainBinding
                                                .locationListController
                                                .getTextColorForMain(
                                                    weatherDetails.weatherItem
                                                            ?.main ??
                                                        ''),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                ),
              )),
        ));
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
      child: mainBinding.locationListController.imageForMain(
        mainBinding.locationListController.weatherNotifier.weathers[pageIndex]
                .weatherItem?.main ??
            '',
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
  }
}