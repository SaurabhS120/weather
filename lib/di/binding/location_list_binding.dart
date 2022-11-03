import 'package:get/get.dart';
import 'package:weather/data/repo_impl/cities_local_repo_impl.dart';
import 'package:weather/data/repo_impl/city_name_to_lat_lon_geo_loc_repo_impl.dart';
import 'package:weather/data/repo_impl/lat_long_to_city_name_repo_impl.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';
import 'package:weather/domain/repo/city_name_to_lat_lon_geo_loc_repo.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class LocationListBinding extends Bindings {
  @override
  void dependencies() {
    CitiesLocalRepo citiesLocalRepo = CitiesLocalRepoImpl() as CitiesLocalRepo;
    citiesLocalRepo.init();
    Get.put(CitiesLocalRepoImpl() as CitiesLocalRepo);
    Get.put(CiityNameToLatLonGeoLocRepoImpl() as CityNameToLatLonGeoLocRepo);
    Get.put(LocationFromCityUsecase());
    Get.put(WeatherController());
    Get.put(LocationListController());
    Get.put(LatLongToCityNameRepoImpl() as LatLongToCityNameRepo);
    Get.put(LatLongToCityNameUsecase());
    Get.put(GeoLocationController());
  }
}