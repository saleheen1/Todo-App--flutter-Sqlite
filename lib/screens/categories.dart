import 'package:flutter/material.dart';
import 'package:todo_sqlite/models/categoryModel.dart';
import 'package:todo_sqlite/others/constants.dart';
import 'package:todo_sqlite/services/category_service.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController _categoryNameEditingController =
      TextEditingController();
  TextEditingController _categoryDescEditingController =
      TextEditingController();
  Category _categoryModel = Category();
  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {},
                child: Text("Cancel", style: TextStyle(color: kGrey)),
              ),
              FlatButton(
                onPressed: () {
                  _categoryModel.name = _categoryNameEditingController.text;
                  _categoryModel.description =
                      _categoryDescEditingController.text;
                  CategoryService().saveCategory(_categoryModel);
                  _categoryDescEditingController.text = "";
                  _categoryNameEditingController.text = "";
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: kPrimaryColor),
                ),
              )
            ],
            title: Text("Create new"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameEditingController,
                    decoration: InputDecoration(
                        // hintText: "Write a category",
                        labelText: "Category Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _categoryDescEditingController,
                    decoration:
                        InputDecoration(labelText: "Category description"),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kGrey,
        ),
        title: Text(
          "Categories",
          style: TextStyle(
              fontSize: 18, color: kGrey, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        elevation: 0.3,
        actions: [],
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(25, 15, 25, 10),
          child: Column(
            children: [
              FlatButton(
                onPressed: () {
                  _showDialog();
                },
                color: kPrimaryColor,
                child: Text(
                  "Create new",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
