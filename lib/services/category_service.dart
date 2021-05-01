import 'package:todo_sqlite/db/db_functions.dart';
import 'package:todo_sqlite/models/categoryModel.dart';

class CategoryService {
  DbFunctions _dbfunctions;
  CategoryService() {
    _dbfunctions = DbFunctions();
  }
  saveCategory(Category category) async {
    return await _dbfunctions.insertData('categories', category.categoryMap());
  }
}
