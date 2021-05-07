import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_sqlite/screens/todoScreen.dart';
import 'package:todo_sqlite/services/todoService.dart';

import 'models/todoModel.dart';
import 'others/constants.dart';
import 'others/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TodoService _todoService;
  List<Todo> _todoList = [];

  @override
  void initState() {
    super.initState();
    _getAllTodo();
  }

  _getAllTodo() async {
    _todoService = TodoService();
    // _todoList = List<Todo>();
    var todos = await _todoService.readTodo();
    todos.forEach((todo) {
      var todoModel = Todo();
      todoModel.id = todo["id"];
      todoModel.title = todo["title"];
      todoModel.description = todo["description"];
      todoModel.category = todo["category"];
      todoModel.todoDate = todo["todoDate"];
      todoModel.isFinished = todo["isFinished"];
      _todoList.add(todoModel);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kGrey, //change your color here
        ),
        title: Text(
          "Todo",
          style: TextStyle(
              fontSize: 18, color: kGrey, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        elevation: 0.3,
        actions: [
          InkWell(
            onTap: () {
              Get.to(TodoScreen());
            },
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.add,
                color: kPrimaryColor,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _todoList != null
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
                    trailing: Text('${_todoList[index].todoDate}'),
                  );
                },
              )
            : Container(
                child: Center(),
              ),
      ),
    );
  }
}
