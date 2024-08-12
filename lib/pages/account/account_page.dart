import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_perfume_application/base/customer_loader.dart';
import 'package:flutter_perfume_application/controller/auth_controller.dart';
import 'package:flutter_perfume_application/controller/cart_controller.dart';
import 'package:flutter_perfume_application/controller/user_controller.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/account.widget.dart';
import 'package:flutter_perfume_application/widgets/app_icons.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Trang cá nhân",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        // Icon Profile
                        AppIcon(
                          icons: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                          size: Dimensions.height15 * 10,
                        ),

                        SizedBox(
                          height: Dimensions.height30,
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Name
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icons: Icons.person,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.name,
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // Phone
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icons: Icons.phone,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.phone,
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // Email
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icons: Icons.email,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.email,
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // Account
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icons: Icons.location_on,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Điền địa chỉ của bạn",
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // Message
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icons: Icons.message,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Tin Nhắn",
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // Logout
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.offNamed(RouteHelper.getSignInPage());
                                    } else {
                                      print("you logged out");
                                    }
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icons: Icons.logout,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: "Đăng Xuất",
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const CustomerLoader())
            : Container(
                child: Center(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 15,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/signin.jpg"))),
                  ),
                  SizedBox(
                    height: Dimensions.height10 * 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: Dimensions.height80 * 4,
                      height: Dimensions.height20 * 2.5,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(100000),
                      ),
                      child: Center(
                          child: BigText(
                        text: "Đăng nhập",
                        color: Colors.white,
                        size: Dimensions.fonts26,
                      )),
                    ),
                  ),
                ],
              )));
      }),
    );
  }
}
