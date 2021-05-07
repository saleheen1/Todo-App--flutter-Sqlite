import 'package:todo_sqlite/db/db_functions.dart';
import 'package:todo_sqlite/models/todoModel.dart';

class TodoService {
  DbFunctions _dbFunctions;
  TodoService() {
    _dbFunctions = DbFunctions();
  }
  saveTodo(Todo todo) async {
    return await _dbFunctions.insertData("todos", todo.todoMap());
  }

  //fetch todo
  readTodo() async {
    return await _dbFunctions.readData("todos");
  }
}
