import 'package:flutter/material.dart';
import 'package:todo_sqlite/others/constants.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController todoTitleController = TextEditingController();

  TextEditingController todoDescController = TextEditingController();

  TextEditingController todoDateController = TextEditingController();

  var _selectedValue;

  var _categories;

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
      body: SafeArea(
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
                      onTap: () {},
                      child: Icon(Icons.calendar_today),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: _selectedValue,
                items: _categories,
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
                        onPressed: () {},
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
    );
  }
}
