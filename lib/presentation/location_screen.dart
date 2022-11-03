import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';

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
  Rx<LocationEntity?> location = Rx<LocationEntity?>(null);
  RxBool _choosingLoc = false.obs;
  String selectedCity = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Location'),
        ),
        body: WillPopScope(
          onWillPop: () {
            if (_choosingLoc.isTrue) {
              _choosingLoc.value = false;
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
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
                        child: Text('Get city from location')),
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
                        child: Text('Choose City'))
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
                        locationListController
                            .add_city(CityEntity(city.value, location.value!));
                        Get.back();
                      }
                    },
                    child: Text('Proceed with selected location '),
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
                                geoLocationController.getLocationFromCityName(
                                    selectedCity, onFinish: () {
                                  _choosingLoc.value = false;
                                });
                              },
                              child: Text('Confirm')),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
