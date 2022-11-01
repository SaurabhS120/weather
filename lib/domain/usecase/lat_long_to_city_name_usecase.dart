import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';

class LatLongToCityNameUsecase {
  LatLongToCityNameRepo latLongToCityNameRepo;

  LatLongToCityNameUsecase(this.latLongToCityNameRepo);

  Future<String> invoke(LocationEntity location) {
    return latLongToCityNameRepo.getCityName(location);
  }
}
