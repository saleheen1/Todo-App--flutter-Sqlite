import 'package:flutter/material.dart';
import 'package:todo_sqlite/models/categoryModel.dart';
import 'package:todo_sqlite/models/todoModel.dart';
import 'package:todo_sqlite/others/constants.dart';
import 'package:todo_sqlite/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todo_sqlite/services/todoService.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController todoTitleController = TextEditingController();

  TextEditingController todoDescController = TextEditingController();

  TextEditingController todoDateController = TextEditingController();

  var _selectedValue;

  var _categoryList = List<DropdownMenuItem>();
  @override
  void initState() {
    super.initState();
    _getAllCategories();
  }

  _getAllCategories() async {
    var categoryService = CategoryService();
    var categories = await categoryService.readCategory();
    categories.forEach((category) {
      // Todo todoModel = Todo();
      // todoModel.title = category["name"];
      // todoModel.description = category["description"];
      // todoModel.id = category["id"];
      setState(() {
        _categoryList.add(DropdownMenuItem(
          child: Text(
            category['name'],
          ),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();
  _selectedDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2021),
        lastDate: DateTime(2099));

    if (_pickedDate != null) {
      setState(() {
        // _dateTime = _pickedDate;
        todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kGrey, //change your color here
        ),
        title: Text(
          "Add todo",
          style: TextStyle(
              fontSize: 18, color: kGrey, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        elevation: 0.3,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                TextField(
                  controller: todoTitleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: todoDescController,
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: todoDateController,
                  decoration: InputDecoration(
                      labelText: "Date",
                      prefixIcon: InkWell(
                        onTap: () {
                          _selectedDate(context);
                        },
                        child: Icon(Icons.calendar_today),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  value: _selectedValue,
                  items: _categoryList,
                  hint: Text("Categories"),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(25, 15, 25, 10),
                    child: Column(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            var todoObj = Todo();
                            todoObj.title = todoTitleController.text;
                            todoObj.description = todoDescController.text;
                            todoObj.isFinished = 0;
                            todoObj.category = _selectedValue;
                            todoObj.todoDate = todoDateController.text;
                            var res = await TodoService().saveTodo(todoObj);
                            print(res);
                          },
                          color: kPrimaryColor,
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
