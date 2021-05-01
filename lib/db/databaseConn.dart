import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory =
        await getApplicationDocumentsDirectory(); //getting the local directory to create database
    var path = join(directory.path,
        'db_todolist'); // creating database, name is db_todolist
    var database = await openDatabase(path, version: 1, onCreate: _dbOnCreate);
    return database;
  }

  _dbOnCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
  }
}
