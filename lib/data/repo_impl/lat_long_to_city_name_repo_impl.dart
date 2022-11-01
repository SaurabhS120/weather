import 'package:geocoding/geocoding.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';

class LatLongToCityNameRepoImpl extends LatLongToCityNameRepo {
  Future<String> getCityName(LocationEntity location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.lattitude, location.longitude);
    Placemark place = placemarks[0];
    return Future.value(place.locality);
  }
}
