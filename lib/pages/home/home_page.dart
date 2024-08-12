import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/pages/account/account_page.dart';
import 'package:flutter_perfume_application/pages/auth/sign_in_page.dart';
import 'package:flutter_perfume_application/pages/auth/sign_up_page.dart';
import 'package:flutter_perfume_application/pages/cart/cart_history.dart';
import 'package:flutter_perfume_application/pages/cart/cart_page.dart';
import 'package:flutter_perfume_application/pages/home/main_perfume_page.dart';
import 'package:flutter_perfume_application/utils/colors.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  //late PersistentTabController _controller;

  List pages = [
    const PerfumeMainPage(),
    //SignInPage(),
    const CartHistory(),
    const CartPage(),
    const AccountPage(),
  ];

  void onTapNav(int index) {  
    setState(() {
      _selectedIndex = index;
    });
  }


   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: BottomNavigationBar
      (
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.iconColor2,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,

        onTap: onTapNav,
        items:
        const [
          BottomNavigationBarItem
          (
            icon: Icon(Icons.home_outlined,),
            label: "Trang Chủ"
          ),

          BottomNavigationBarItem
          (
            icon: Icon(Icons.archive,),
           label: "Lịch Sử ĐH"
          ),

          BottomNavigationBarItem
          (
            icon: Icon(Icons.shopping_cart,),
           label: "Giỏ Hàng"
          ),

           BottomNavigationBarItem
          (
            icon: Icon(Icons.person,),
            label: "Cá Nhân"
          ),
        ],
      ),
    );
  }
}
