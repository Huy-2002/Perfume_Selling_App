import 'package:flutter_perfume_application/controller/auth_controller.dart';
import 'package:flutter_perfume_application/controller/cart_controller.dart';
import 'package:flutter_perfume_application/controller/popular_perfume_controller.dart';
import 'package:flutter_perfume_application/controller/recommended_perfume_controller.dart';
import 'package:flutter_perfume_application/controller/user_controller.dart';
import 'package:flutter_perfume_application/data/api/api_client.dart';
import 'package:flutter_perfume_application/data/repository/auth_repo.dart';
import 'package:flutter_perfume_application/data/repository/cart_repo.dart';
import 'package:flutter_perfume_application/data/repository/popular_perfume_repo.dart';
import 'package:flutter_perfume_application/data/repository/recommanded_perfume_repo.dart';
import 'package:flutter_perfume_application/data/repository/user_repo.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async
{
    // sharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);

    // api client
    Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences:Get.find()));
    Get.lazyPut(()=> AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.lazyPut(()=> UserRepo(apiClient: Get.find()));

    // repos
    Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));
    Get.lazyPut(() => RecommendedProductRepo(apiClient:Get.find()));
    Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));


    
    // controllers
    Get.lazyPut(() => AuthController(authRepo: Get.find()));
    Get.lazyPut(() => UserController(userRepo: Get.find()));
    Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
    Get.lazyPut(() => RecommendedProductController(recommendedProductRepo:Get.find()));
    Get.lazyPut(() => CartController(cartRepo: Get.find()),);
    
}