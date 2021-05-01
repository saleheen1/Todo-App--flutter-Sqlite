import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite/db/databaseConn.dart';

class DbFunctions {
  DatabaseConnection
      _databaseConnection; //DatabaseConnection is the class name of databaseConn.dart file
  DbFunctions() {
    //initializing database connection
    _databaseConnection = DatabaseConnection();
  }
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      //if the database already exists
      return _database;
    } else {
      //else create the database and return it
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //Inserting data to table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }
}