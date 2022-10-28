import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/location_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
class LocationGeolocatorRepo extends LocationRepo{

  @override
  Future<LocationEntity> getLocation() async{
    bool isServiceEnabled ;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!isServiceEnabled){
      return Future.error("Location not enabled");
    }
    locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.deniedForever){
      return Future.error("Location permissions are denined forever ");
    }else if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied){
        return Future.error('Location permission is denied');
      }
    }
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)        ;
    var positionEntity = LocationEntity(position.latitude, position.longitude);
    return Future.value(positionEntity);
  }


}