import 'package:weather/domain/mappers/location_mapper.dart';
import 'package:weather/domain/repo/location_repo.dart';
import 'package:weather/presentation/item/location_item.dart';
class LocationUseCase {
  LocationRepo locationRepo;

  LocationUseCase(this.locationRepo);

  Future<LocationItem> invoke() async =>
      (await locationRepo.getLocation()).toItem();
}