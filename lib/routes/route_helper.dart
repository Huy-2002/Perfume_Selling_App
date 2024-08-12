import 'package:flutter_perfume_application/pages/auth/sign_in_page.dart';
import 'package:flutter_perfume_application/pages/cart/cart_page.dart';
import 'package:flutter_perfume_application/pages/home/home_page.dart';
import 'package:flutter_perfume_application/pages/home/main_perfume_page.dart';
import 'package:flutter_perfume_application/pages/perfume/popular_perfume_detail.dart';
import 'package:flutter_perfume_application/pages/perfume/recommanded_perfume_detail.dart';
import 'package:flutter_perfume_application/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper
{
    
    static const String initial = "/";
    static String getInitial() => '$initial';

    static const String popularPerfume = "/popular-perfume";
    static String getPopularProductList(int pageId, String page) => '$popularPerfume?pageId=$pageId&page=$page';

    static const String recommendedPerfume = "/recommended-perfume";
    static String getRecommendedProductList(int pageId, String page) => '$recommendedPerfume?pageId=$pageId&page=$page';

    static const String cartPage = "/cart-page";
    static String getCartPage()=> "$cartPage";

    static const String splashPage = "/splash-page";
    static String getSplashPage()=> "$splashPage";

    static const String signIn = "/sign-in";
    static String getSignInPage()=>'$signIn';

    static List<GetPage> routes = [
        GetPage(name: splashPage, page: ()=>SplashScreen()),

        GetPage(name: initial, page: ()=>HomePage()),

        GetPage(name: signIn, page: ()=>SignInPage(), transition: Transition.fade),

        // Popular Perfume
        GetPage(name: popularPerfume, page:()
        {
            var pageId = Get.parameters['pageId'];
            var page = Get.parameters['page'];
            return PopularPerfumeDetail(pageId:int.parse(pageId!), page:page!);
        },

        transition: Transition.fadeIn
        ),

        // Recommended Perfume
         GetPage(name: recommendedPerfume, page:()
        {
            var pageId = Get.parameters['pageId'];
            var page = Get.parameters['page'];

            return RecommandedPerfumeDetail(pageId:int.parse(pageId!), page:page!);
        },

        transition: Transition.fadeIn
        ),

        // Cart Page
        GetPage(name: cartPage, page: (){
            return CartPage();
        },

        transition: Transition.fadeIn
        ),
    ];
}