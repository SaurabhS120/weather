import 'package:weather/domain/entity/location_entity.dart';

abstract class LocationRepo {
  Future<LocationEntity> getLocation();
}
