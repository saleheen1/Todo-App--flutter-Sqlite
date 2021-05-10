import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_sqlite/models/categoryModel.dart';
import 'package:todo_sqlite/others/constants.dart';
import 'package:todo_sqlite/screens/categories_screen.dart';
import 'package:todo_sqlite/screens/todoByCategory.dart';
import 'package:todo_sqlite/services/category_service.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  CategoryService _categoryService = CategoryService();

  List categoryList = List();

  _getAllCategory() async {
    var _categories = await _categoryService.readCategory();
    _categories.forEach((category) {
      Category _categoryModel = Category();
      _categoryModel.name = category["name"];
      _categoryModel.description = category["description"];
      _categoryModel.id = category["id"];
      categoryList.add(_categoryModel);
    });
    return categoryList;
  }

  // @override
  // void initState() {
  //   _getAllCategory();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 167,
              // height: 120,
              child: DrawerHeader(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                  ),
                ],
              )),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.contactless_sharp),
                  title: Text("Categories"),
                  onTap: () {
                    Get.to(Categories());
                  },
                ),
              ),
            ),
            FutureBuilder(
              future: _getAllCategory(),
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(TodoByCategory(
                            category: snapshot.data[index].name,
                          ));
                        },
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.circle,
                              color: kPrimaryColor,
                              size: 10,
                            ),
                            onPressed: () {
                              // _editCategory(_categoryList[index].id);
                            },
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${snapshot.data[index].name}'),
                            ],
                          ),
                          // subtitle: Text('${_categoryList[index].description}'),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
