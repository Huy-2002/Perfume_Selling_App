import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_perfume_application/controller/popular_perfume_controller.dart';
import 'package:flutter_perfume_application/controller/recommended_perfume_controller.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  
  Future<void> _loadResources() async {
    // Get Data From Laravel
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();

    //load Resources
    _loadResources();

    // Animation
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))..forward();
      animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    // Splash xong nhay zo trang chinh
    Timer(const Duration(seconds: 3),()=>Get.offNamed(RouteHelper.getInitial()));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              "assets/images/logo.jpg",
              width: Dimensions.splashImage,
            )),
          ),

          // Center(
          //     child: Image.asset(
          //   "assets/images/logo.jpg",
          //   width: 250,
          // )),
        ],
      ),
    );
  }
}
