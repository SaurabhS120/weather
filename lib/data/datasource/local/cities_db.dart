import 'package:sqflite/sqflite.dart';
import 'package:weather/data/entity/city_db_entity.dart';

class CitiesDB {
  Database? database;

  Future<Database?> init() async {
    if (database == null) {
      var databasesPath = await getDatabasesPath();
      String path = databasesPath + '/City.db';
      // open the database
      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE City (id INTEGER PRIMARY KEY, name TEXT, latitude TEXT, longitude TEXT)');
      });
    }
    return database;
  }

  Future<void> addCity(CityDBEntity city) async {
    var data = {
      'name': city.cityName,
      'latitude': city.longitude,
      'longitude': city.lattitude,
    };
    await (await init())!.insert('City', data);
  }

  Future<List<CityDBEntity>> getCities() async {
    var response = await (await init())!.rawQuery('SELECT * FROM City');
    return response
        .map((e) => CityDBEntity(e['name'].toString(), e['latitude'] as String,
            e['longitude'] as String))
        .toList();
  }

  void removeCity(String cityName) async {
    (await init())!.delete('City', where: "name=?", whereArgs: [cityName]);
  }
}
