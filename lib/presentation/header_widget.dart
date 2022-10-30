import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';

class HeaderWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget> {
  String city = '';
  final GeoLocationController geoLocationController =
      Get.put(GeoLocationController(), permanent: true);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          child: Text(city),
        ),
      ],
    );
  }

  getAddress(lat, lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemarks[0];
    print(place.locality);
    setState(() {
      city = place.locality!;
    });
  }
}
