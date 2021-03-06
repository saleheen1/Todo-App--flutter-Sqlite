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

  //fetch category by id
  readCategoryById(categoryId) async {
    return await _dbfunctions.readDataById("categories", categoryId);
  }

  //update category by id
  updateCategory(Category categoryModel) async {
    return await _dbfunctions.updateData(
        "categories", categoryModel.categoryMap());
  }

  deleteCategory(id) async {
    await _dbfunctions.deleteData("categories", id);
  }

  //read todos by category
  readTodosByCategory(category) async {
    return await _dbfunctions.readDataByColumn("todos", "category", category);
  }
}
