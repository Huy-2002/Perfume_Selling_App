import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/controller/cart_controller.dart';
import 'package:flutter_perfume_application/controller/popular_perfume_controller.dart';
import 'package:flutter_perfume_application/controller/recommended_perfume_controller.dart';
import 'package:flutter_perfume_application/pages/auth/sign_in_page.dart';
import 'package:flutter_perfume_application/pages/auth/sign_up_page.dart';
import 'package:flutter_perfume_application/pages/cart/cart_page.dart';
import 'package:flutter_perfume_application/pages/home/main_perfume_page.dart';
import 'package:flutter_perfume_application/pages/perfume/popular_perfume_detail.dart';
import 'package:flutter_perfume_application/pages/perfume/recommanded_perfume_detail.dart';
import 'package:flutter_perfume_application/pages/splash/splash_page.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    // Lưu dữ liệu giỏ hàng ở local device
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: SignInPage(),
          //home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
