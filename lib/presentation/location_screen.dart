import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/notifiers/location_notifier.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  final geoLocationController = Get.find<GeoLocationController>();
  final locationListController = Get.find<LocationListController>();
  String selectedCity = '';
  var choosingLoc = false;

  @override
  void initState() {
    geoLocationController.init();
    geoLocationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => geoLocationController.locationNotifier,
          builder: (context, child) => Consumer<LocationNotifier>(
            builder: (context, location, child) => WillPopScope(
              onWillPop: () {
                if (choosingLoc) {
                  choosingLoc = false;
                  setState(() {});
                  return Future.value(false);
                } else {
                  setState(() {});
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
                                  geoLocationController.getCurrentLocation();
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
                                  choosingLoc = true;
                                  setState(() {});
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
                          onPressed: () {
                            if (location == null) {
                                  Get.snackbar("Location error",
                                      "Please select location to proceed");
                                } else {
                                  locationListController
                                      .add_city(location.city!);
                                  Get.back();
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
                            visible: choosingLoc,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectState(
                                    onCityChanged: (value) {
                                      selectedCity = value;
                                      setState(() {});
                                    },
                                    onCountryChanged: (value) {},
                                    onStateChanged: (value) {},
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      geoLocationController
                                          .getLocationFromCityName(selectedCity,
                                              onFinish: () {
                                        choosingLoc = false;
                                        setState(() {});
                                      });
                                    },
                                    child: Text('Confirm'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black54),
                                  ),
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
      ),
    );
  }
}
