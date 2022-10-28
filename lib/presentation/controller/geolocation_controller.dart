import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/data/repo_impl/location_geolocator_repo.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/location_repo.dart';
class GeoLocationController extends GetxController{
  final RxBool _isLoading = true.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxDouble _lattitude   = 0.0.obs;

  RxBool checkLoading()=>_isLoading;
  RxDouble getLattitude()=>_lattitude;
  RxDouble getLongitude()=>_longitude;

  @override
  void onInit(){
    getLocation();
    super.onInit();
  }
  LocationRepo locationRepo = LocationGeolocatorRepo();
  void getLocation() async{
    LocationEntity location = await locationRepo.getLocation();
    _longitude.value = location.longitude;
    _lattitude.value = location.lattitude;
    _isLoading.value = false;
  }

}