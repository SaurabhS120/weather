import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/binding/main_binding.dart';

import 'notifiers/weather_notifier.dart';

class LocationListScreen extends StatefulWidget {
  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  late MainBinding mainBinding;

  @override
  Widget build(BuildContext context) {
    mainBinding = Provider.of<MainBinding>(context);
    mainBinding.locationListController.updateData();

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(100, 100, 100, 1.0),
          Color.fromRGBO(0, 0, 0, 1)
        ], begin: Alignment(0, -1), end: Alignment(0, 1))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColoredBox(
              color: Color.fromRGBO(0, 0, 0, 0.7490196078431373),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => null,
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    Text(
                      'City list',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/location'),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(child: LocationListWidget()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ChangeNotifierProvider.value(
                  value: mainBinding.locationListController.weatherNotifier,
                  child: Consumer<WeatherNotifier>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () {
                        if (value.weathers.isEmpty) {
                          const snackBar = SnackBar(
                            content: Text(
                              'Please add atleast one location to proceed',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          mainBinding.geoLocationController
                              .setLocation(value.weathers[0].cityItem!);
                          // mainBinding.weatherController.set(
                          //     value.weathers[0].cityItem!);
                          Navigator.of(context).pushNamed('/home');
                        }
                      },
                      child: Text('Proceed'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.2)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class LocationListWidget extends StatefulWidget {
  @override
  State<LocationListWidget> createState() => _LocationListWidgetState();
}

class _LocationListWidgetState extends State<LocationListWidget> {
  late MainBinding mainBinding;

  @override
  Widget build(BuildContext context) {
    mainBinding = Provider.of<MainBinding>(context);
    return ChangeNotifierProvider.value(
        value: mainBinding.locationListController.weatherNotifier,
        child: Consumer<WeatherNotifier>(
          builder: (context, value, child) => GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: value.weathers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () =>
                    mainBinding.locationListController.remove(index),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              value.weathers[index].cityItem?.cityName ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                                Text(
                                  value.weathers[index].weatherItem?.main ?? '',
                              style: TextStyle(color: Colors.white),
                            )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () => mainBinding
                                  .locationListController
                                  .remove(index),
                            ),
                            mainBinding.locationListController.imageForMain(
                                value.weathers[index].weatherItem?.icon ?? '',
                                height: 24,
                                width: 24,
                                color: Colors.white),
                          ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "${value.weathers[index].weatherItem?.temp}°",
                              style: TextStyle(color: Colors.white),
                            ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
        ));
  }
}
