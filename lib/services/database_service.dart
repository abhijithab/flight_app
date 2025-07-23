import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/flight_model.dart';

class DatabaseService {
  static Database? _database;
  static const String _tableName = 'flights';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'flights.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> saveFlightData(FlightModel flightModel) async {
    final db = await database;
    await db.delete(_tableName);
    await db.insert(_tableName, {'data': jsonEncode(flightModel.toJson())});
  }

  Future<FlightModel?> getFlightData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    if (maps.isNotEmpty) {
      return FlightModel.fromJson(jsonDecode(maps.first['data']));
    }
    return null;
  }

  Future<bool> hasData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.isNotEmpty;
  }
}
