import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/base/customer_loader.dart';
import 'package:flutter_perfume_application/base/show_customer_snackbar.dart';
import 'package:flutter_perfume_application/controller/auth_controller.dart';
import 'package:flutter_perfume_application/pages/auth/sign_up_page.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/app_text_field.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var accountController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String account = accountController.text.trim();
      String password = passwordController.text.trim();

      if (account.isEmpty) {
        showCustomSnackBar(" Tài khoản không được để trống",
            title: "Thông báo");
      } else if (!GetUtils.isEmail(account)) {
        showCustomSnackBar(" Tài khoản phải hợp lệ, yêu cầu kí tự @",
            title: "Thông báo");
      } else if (password.isEmpty) {
        showCustomSnackBar(" Mật khẩu không được để trống", title: "Thông báo");
      } else if (password.length < 6) {
        showCustomSnackBar(" Mật khẩu có tối thiểu 6 kí tự",
            title: "Thông báo");
      } else {
        authController.login(account, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
           

          } else {
            showCustomSnackBar(status.message);
          }
        });

        // print(signUpBody.toString());
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController) {
      return !authController.isLoading ? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),

            // APP LOGO
            SizedBox(
              height: Dimensions.screenHeight * 0.35,
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/logo.jpg"),
                ),
              ),
            ),

            // Sign in
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              child: Column(
                children: [
                  Text(
                    "Đăng nhập",
                    style: TextStyle(
                        fontSize: Dimensions.fonts20 + 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),

            SizedBox(
              height: Dimensions.screenHeight * 0.03,
            ),

            // Account
            AppTextField(
                textController: accountController,
                hintText: "Tài khoản",
                icon: Icons.email),
            SizedBox(
              height: Dimensions.height20,
            ),

            // Password
            AppTextField(
                textController: passwordController,
                hintText: "Mật khẩu",
                icon: Icons.password,
                isObscure: true),
            SizedBox(
              height: Dimensions.height20,
            ),

            // Tag Line
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                    text: TextSpan(
                        text: "Quên mật khẩu",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.fonts20))),
                SizedBox(width: Dimensions.width20),
              ],
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),

            // Nút Dăng Nhập
            GestureDetector(
              onTap: () {
                _login(authController);
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 14,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor),
                child: Center(
                  child: BigText(
                    text: "Đăng nhập",
                    size: Dimensions.fonts20 + Dimensions.fonts20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: Dimensions.height10,
            ),

            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),

            // Sign In Options
            RichText(
                text: TextSpan(
              text: "Bạn chưa có tài khoản? ",
              style: TextStyle(
                  color: Colors.grey[500], fontSize: Dimensions.font16),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        Get.to(() => SignUpPage(), transition: Transition.fade),
                  text: "Tạo tài khoản",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBlackColor,
                      fontSize: Dimensions.fonts20),
                )
              ],
            )),
          ],
        ),
      ): CustomerLoader();
    }));
  }
}
