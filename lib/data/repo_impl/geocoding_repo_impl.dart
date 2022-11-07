import 'package:geocoding/geocoding.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';

class GeoCodingRepoImpl extends LatLongToCityNameRepo {
  Future<String> getCityName(LocationModel location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.lattitude, location.longitude);
    print(placemarks.length);
    Placemark place = placemarks[0];
    return Future.value(place.locality);
  }
}
