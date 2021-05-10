import 'package:flutter/material.dart';
import 'package:todo_sqlite/models/todoModel.dart';
import 'package:todo_sqlite/others/constants.dart';
import 'package:todo_sqlite/services/category_service.dart';
import 'package:todo_sqlite/services/todoService.dart';

class TodoByCategory extends StatefulWidget {
  final String category;
//constructor to receice category that user pressed
  const TodoByCategory({Key key, this.category}) : super(key: key);

  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  List _todoList = List<Todo>();
  CategoryService _todoService = CategoryService();

  getTodosByCategory() async {
    var todos = await _todoService.readTodosByCategory(this.widget.category);

    todos.forEach((todo) {
      setState(() {
        var todoModel = Todo();
        todoModel.title = todo["title"];
        todoModel.description = todo["description"];
        todoModel.todoDate = todo["todoDate"];
        _todoList.add(todoModel);
      });
    });
  }

  @override
  void initState() {
    getTodosByCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.category),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _todoList != null
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // _editCategory(_categoryList[index].id);
                        },
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_todoList[index].title}'),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // _deleteCategoryDialog(_categoryList[index].id);
                            },
                          )
                        ],
                      ),
                      subtitle: Text('${_todoList[index].description}'),
                    );
                  },
                )
              : Container(
                  color: kPrimaryColor,
                  height: 20,
                  width: double.infinity,
                  child: Center(),
                ),
        ],
      )),
    );
  }
}
