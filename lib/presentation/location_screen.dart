import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class LocationScreen extends StatelessWidget {
  final geoLocationController = Get.find<GeoLocationController>();
  final weatherController = Get.find<WeatherController>();
  late RxBool fetching_location;
  RxString city = ''.obs;
  Rx<LocationEntity?> location = Rx<LocationEntity?>(null);
  RxBool _choosing_loc = false.obs;
  String selected_city = '';
  final location_list_controller = Get.find<LocationListController>();

  LocationScreen() {
    fetching_location = geoLocationController.checkLoading();
    geoLocationController.getCity().listen((city) {
      this.city.value = city;
    });
    geoLocationController.getLocationEntity().listen((location) {
      this.location.value = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Location'),
        ),
        body: WillPopScope(
          onWillPop: () {
            if (_choosing_loc.isTrue) {
              _choosing_loc.value = false;
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
                          _choosing_loc.value = true;
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
                        location_list_controller
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
                      visible: fetching_location.isTrue,
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
                    visible: _choosing_loc.isTrue,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectState(
                            onCityChanged: (value) {
                              selected_city = value;
                            },
                            onCountryChanged: (value) {},
                            onStateChanged: (value) {},
                          ),
                          ElevatedButton(
                              onPressed: () {
                                geoLocationController.getLocationFromCityName(
                                    selected_city, onFinish: () {
                                  _choosing_loc.value = false;
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
