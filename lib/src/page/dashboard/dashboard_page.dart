import 'package:flutter/material.dart';
import 'package:fluttercoffee/src/page/dashboard/tab/card_page.dart';
import 'package:fluttercoffee/src/page/dashboard/tab/categories_page.dart';
import 'package:fluttercoffee/src/page/dashboard/tab/home_page.dart';
import 'package:fluttercoffee/src/page/dashboard/tab/profile_page.dart';
import 'package:fluttercoffee/src/util/const.dart';

class DashboardScreenPage extends StatefulWidget {

  String uid;
  DashboardScreenPage({Key key, this.uid}) : super(key: key);


  @override
  _DashboardScreenPageState createState() => _DashboardScreenPageState(uid);
}

class _DashboardScreenPageState extends State<DashboardScreenPage> {
   final String uid1;
   _DashboardScreenPageState(this.uid1);
  int currentIndex = 0;
  List<Widget> listScreen() => [

    HomePage(),
    CategoriesPage(),
    CardPage(),
    ProfilePage(uid: uid1,),
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> children = listScreen();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: kColorGreen,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            _buildBottomNavigationBarItem(Icons.home,"Home"),
            _buildBottomNavigationBarItem(Icons.free_breakfast,"Categories"),
            _buildBottomNavigationBarItem(Icons.shopping_cart, "Card"),
            _buildBottomNavigationBarItem(Icons.person, "Profile"),
          ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: children
      ),
    );
  }
}
_buildBottomNavigationBarItem(IconData iconData, String text) {
  return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        size: 27,
      ),
      title: Text(text,style: TextStyle(fontWeight: FontWeight.bold),));
}
