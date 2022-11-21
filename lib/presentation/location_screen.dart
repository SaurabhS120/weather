import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/binding/main_binding.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/notifiers/location_notifier.dart';
import 'package:weather/presentation/notifiers/weather_notifier.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late MainBinding mainBinding;

  @override
  Widget build(BuildContext context) {
    mainBinding = Provider.of<MainBinding>(context);
    WeatherNotifier weatherNotifier = Provider.of<WeatherNotifier>(context);
    return SafeArea(
      child: Scaffold(
        body: Consumer<LocationNotifier>(
          builder: (context, location, child) => WillPopScope(
            onWillPop: () {
              if (location.choosingLoc) {
                location.setChoosingLoc(false);
                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            child: Column(
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
                          'Add city',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(
                          height: 24,
                          width: 72,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black38, Colors.black54],
                                begin: Alignment(0, -1),
                                end: Alignment(0, 1))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Selected location : ${location.city?.cityName}'),
                            SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                location.getCurrentLocation();
                              },
                              child: Text('Get city from location'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black54),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text('OR'),
                            SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                location.setChoosingLoc(true);
                              },
                              child: Text('Choose City'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black54),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (location == null) {
                                const snackBar = SnackBar(
                                  content:
                                      Text('Please select location to proceed'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                await weatherNotifier.add_city(location.city!);
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Proceed with selected location '),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black54),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: location.fetchingLocation,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.9)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  Text('Getting current location'),
                                ],
                              ),
                            ),
                          )),
                      Visibility(
                          visible: location.choosingLoc,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SelectState(
                                  onCityChanged: (value) {
                                    location.selectCity(value);
                                  },
                                  onCountryChanged: (value) {},
                                  onStateChanged: (value) {},
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    var city = await mainBinding
                                        .locationFromCityUsecase
                                        .invoke(location.selectedCity);
                                    location.setLocation(
                                        CityItem(location.selectedCity, city));
                                    location.getLocationFromCityName(
                                        location.selectedCity, onFinish: () {
                                      location.setChoosingLoc(false);
                                    });
                                  },
                                  child: Text('Confirm'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black54),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
