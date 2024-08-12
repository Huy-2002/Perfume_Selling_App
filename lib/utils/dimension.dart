import 'package:get/get.dart';

class Dimensions {
    static double screenHeight = Get.context!.height;
    static double screenWidth = Get.context!.width;

    static double pageView = screenHeight / 2.91;
    static double pageViewController = screenHeight / 4.23;
    static double pageViewTextController = screenHeight / 6.65; 

    // Dynamic height padding and margin
    static double height10 = screenHeight / 93.2; // 932/10
    static double height15 = screenHeight / 62.13;
    static double height20 = screenHeight / 46.6;
    static double height30 = screenHeight / 31.06;
    static double height45 = screenHeight / 20.71;
    static double height80 = screenHeight / 11.65;



    // Dynamic width padding and margin
    static double width10 = screenHeight / 93.2; // 932/10
    static double width15 = screenHeight / 62.13;
    static double width20 = screenHeight / 46.6;
    static double width30 = screenHeight / 31.06;
    static double width50 = screenHeight / 18.64;

    // font size
    static double font16 = screenHeight / 58.25;
    static double fonts20 = screenHeight / 46.6;
    static double fonts26 = screenHeight / 35.84;


    // Radius
    static double radius15 = screenHeight / 62.13;
    static double radius20 = screenHeight / 46.6;
    static double radius30 = screenHeight / 31.06;

    // Icon size
    static double iconSize24 = screenHeight / 38.83;
    static double iconSize16 = screenHeight / 58.25;


    // List View Size
    static double ListViewImageSize = screenHeight / 7.76; 
    static double ListViewTextContSize = screenHeight / 7.76;

    //Popular Perfume
    static double popularPerfumeImageSize = screenHeight / 2.15;

    // Bottom height
    static double bottomHeightBar = screenHeight / 7.76;

    // Splash Page
    static double splashImage = screenHeight / 3.72;
}