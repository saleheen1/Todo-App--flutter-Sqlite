import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_sqlite/screens/categories.dart';

class AppDrawer extends StatelessWidget {
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
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //   alignment: Alignment.bottomLeft,
                    //   image: AssetImage('assets/images/mosque.png'),
                    //   fit: BoxFit.fitHeight,
                    // )),
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
            ListTile(
              leading: Icon(Icons.star_purple500_outlined),
              title: Text("Buy premium"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.star,
              ),
              title: Text(
                "Rate us",
              ),
            ),
            ListTile(
              leading: Icon(Icons.design_services_sharp),
              title: Text("About"),
              onTap: () {},
            ),
            ListTile(
                leading: Icon(Icons.broken_image_sharp),
                title: Text("Report a bug"),
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
