import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/location_item.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  final geoLocationController = Get.find<GeoLocationController>();
  final locationListController = Get.find<LocationListController>();
  @override
  void initState() {
    super.initState();
    fetchingLocation = geoLocationController.checkLoading();
    geoLocationController.getCity().listen((city) {
      this.city.value = city;
    });
    geoLocationController.getLocationEntity().listen((location) {
      this.location.value = location;
    });
  }

  late RxBool fetchingLocation;
  RxString city = ''.obs;
  Rx<LocationItem?> location = Rx<LocationItem?>(null);
  RxBool _choosingLoc = false.obs;
  String selectedCity = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () {
            if (_choosingLoc.isTrue) {
              _choosingLoc.value = false;
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
                          Obx(() => Text('Selected location : $city')),
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
                              _choosingLoc.value = true;
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
                            if (location.value == null) {
                              Get.snackbar("Location error",
                                  "Please select location to proceed");
                            } else {
                              locationListController.add_city(
                                  CityItem(city.value, location.value!));
                              Get.back();
                            }
                          },
                          child: Text('Proceed with selected location '),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black54),
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        return Visibility(
                            visible: fetchingLocation.isTrue,
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
                            ));
                      },
                    ),
                    Obx(
                      () => Visibility(
                          visible: _choosingLoc.isTrue,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SelectState(
                                  onCityChanged: (value) {
                                    selectedCity = value;
                                  },
                                  onCountryChanged: (value) {},
                                  onStateChanged: (value) {},
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    geoLocationController
                                        .getLocationFromCityName(selectedCity,
                                            onFinish: () {
                                      _choosingLoc.value = false;
                                    });
                                  },
                                  child: Text('Confirm'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black54),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
