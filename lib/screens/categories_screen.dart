import 'package:flutter/material.dart';
import 'package:todo_sqlite/models/categoryModel.dart';
import 'package:todo_sqlite/others/constants.dart';
import 'package:todo_sqlite/services/category_service.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  _showUpdateSnack(message) {
    var _snack = SnackBar(
      content: message,
      backgroundColor: kPrimaryColor,
    );
    _globalKey.currentState.showSnackBar(_snack);
  }

  TextEditingController _categoryNameEditingController =
      TextEditingController();
  TextEditingController _categoryDescEditingController =
      TextEditingController();

  TextEditingController _edit_categoryNameController = TextEditingController();
  TextEditingController _edit_categoryDescController = TextEditingController();
  Category _categoryModel = Category();
  var categoryG;

  //fetching category
  List<Category> _categoryList = [];
  getAllCategories() async {
    var categories = await CategoryService().readCategory();
    categories.forEach((category) {
      //don't forget to get instance of Category inside here otherwise it won't work
      Category categoryModel = Category();
      categoryModel.name = category["name"];
      categoryModel.description = category["description"];
      categoryModel.id = category["id"];

      _categoryList.add(categoryModel);
    });
    setState(() {});
  }

  //edit category
  _editCategory(categoryId) async {
    categoryG = await CategoryService().readCategoryById(categoryId);

    setState(() {
      _edit_categoryNameController.text = categoryG[0]["name"] ?? 'No Name';
      _edit_categoryDescController.text =
          categoryG[0]["description"] ?? 'No Description';
    });
    _editFormDialog();
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Cancel", style: TextStyle(color: kGrey)),
              ),
              FlatButton(
                onPressed: () async {
                  _categoryModel.name = _categoryNameEditingController.text;
                  _categoryModel.description =
                      _categoryDescEditingController.text;
                  var result =
                      await CategoryService().saveCategory(_categoryModel);
                  print(result);
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

  _editFormDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Cancel", style: TextStyle(color: kGrey)),
              ),
              FlatButton(
                onPressed: () async {
                  _categoryModel.id = categoryG[0]['id'];
                  _categoryModel.name = _edit_categoryNameController.text;
                  _categoryModel.description =
                      _edit_categoryDescController.text;
                  var result =
                      await CategoryService().updateCategory(_categoryModel);

                  Navigator.of(context).pop(true);
                  _showUpdateSnack(Text("Category updated"));
                  setState(() {});
                },
                child: Text(
                  "Update",
                  style: TextStyle(color: kPrimaryColor),
                ),
              )
            ],
            title: Text("Edit category"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _edit_categoryNameController,
                    decoration: InputDecoration(
                        // hintText: "Write a category",
                        labelText: "Category Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _edit_categoryDescController,
                    decoration:
                        InputDecoration(labelText: "Category description"),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteCategoryDialog(categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Cancel", style: TextStyle(color: kGrey)),
              ),
              FlatButton(
                onPressed: () async {
                  // _categoryModel.id = categoryG[0]['id'];
                  // _categoryModel.name = _edit_categoryNameController.text;
                  // _categoryModel.description =
                  //     _edit_categoryDescController.text;

                  await CategoryService().deleteCategory(categoryId);

                  Navigator.of(context).pop(true);
                  _showUpdateSnack(Text("Category deleted"));
                  setState(() {});
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
            title: Text("Are you sure?"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _categoryList != null
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _categoryList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editCategory(_categoryList[index].id);
                          },
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${_categoryList[index].name}'),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteCategoryDialog(_categoryList[index].id);
                              },
                            )
                          ],
                        ),
                        subtitle: Text('${_categoryList[index].description}'),
                      );
                    },
                  )
                : Container(
                    child: Center(),
                  ),
            Container(
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
          ],
        ),
      ),
    );
  }
}
