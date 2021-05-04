import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_sqlite/screens/todoScreen.dart';

import 'others/constants.dart';
import 'others/drawer.dart';

class Home extends StatelessWidget {
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
    );
  }
}
