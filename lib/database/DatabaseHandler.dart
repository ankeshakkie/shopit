import 'package:shopit/constants/Constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler
{
  static final DatabaseHandler _databaseHandler = DatabaseHandler ._internal();
  static Database? _database;

  factory DatabaseHandler()
  {
    return _databaseHandler;
  }


  DatabaseHandler._internal();

  Future<Database?> openDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(),Constants.DATABASE_NAME)
    );

    return _database;
  }
}