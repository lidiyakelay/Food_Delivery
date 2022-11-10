import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/utils/colors.dart';

import 'main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPage=0;
  List pages=[MainFoodPage(),
    Container(color: Colors.white,child: Center(child: Text('page 2'),),),
    CartHistory(),
    AccountPage()];
  void onTap(int index){
    setState((){
      _selectedPage=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedPage,
        onTap: onTap ,
        items:const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive,),
              label: 'History'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,),
              label: 'Cart'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,),
              label: 'me'
          ),

        ],
      ),
    );
  }
}








