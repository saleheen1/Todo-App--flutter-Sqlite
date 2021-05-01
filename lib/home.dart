import 'package:flutter/material.dart';

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
          // InkWell(
          //   onTap: () {
          //     _scaffoldKey.currentState.openDrawer();
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.fromLTRB(20, 19, 25, 10),
          //     child: Icon(
          //       Icons.menu,
          //       color: kGrey,
          //       size: 28,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
