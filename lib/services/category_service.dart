import 'package:todo_sqlite/db/db_functions.dart';
import 'package:todo_sqlite/models/categoryModel.dart';

class CategoryService {
  DbFunctions _dbfunctions;
  CategoryService() {
    _dbfunctions = DbFunctions();
  }
  //insert category into database
  saveCategory(Category category) async {
    return await _dbfunctions.insertData('categories', category.categoryMap());
  }

  //fetch category from database
  readCategory() async {
    return await _dbfunctions.readData("categories");
  }
}
