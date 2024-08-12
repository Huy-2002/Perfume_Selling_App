import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/base/customer_loader.dart';
import 'package:flutter_perfume_application/base/show_customer_snackbar.dart';
import 'package:flutter_perfume_application/controller/auth_controller.dart';
import 'package:flutter_perfume_application/model/sign_up_body_model.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/app_icons.dart';
import 'package:flutter_perfume_application/widgets/app_text_field.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var accountController = TextEditingController();
    var passwordController = TextEditingController();
    var usernameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImage = [
      "f.png",
      "g.png",
      "t.png",
    ];

    void _registration(AuthController authController) {
      
      String account = accountController.text.trim();
      String password = passwordController.text.trim();
      String username = usernameController.text.trim();
      String phone = phoneController.text.trim();

      // Kiểm tra các trường nhập vào có bị rỗng
      if (username.isEmpty) {
        showCustomSnackBar(" Tên người dùng không được để trống",
            title: "Thông báo");
      } else if (phone.isEmpty) {
        showCustomSnackBar(" Số điện thoại không được để trống",
            title: "Thông báo");
      } else if (phone.isEmpty) {
        showCustomSnackBar(" Số điện thoại không được để trống",
            title: "Thông báo");
      } else if (account.isEmpty) {
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
        SignUpBody signUpBody = SignUpBody(
          username: username,
          phone: phone,
          account: account,
          password: password,
        );

        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Đăng ký thành công");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });

        // print(signUpBody.toString());
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.03,
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

              // Username
              AppTextField(
                  textController: usernameController,
                  hintText: "Tên người dùng",
                  icon: Icons.person),
              SizedBox(
                height: Dimensions.height20,
              ),

              // Phone
              AppTextField(
                  textController: phoneController,
                  hintText: "Số điện thoại",
                  icon: Icons.phone),
              SizedBox(
                height: Dimensions.height30,
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
                  icon: Icons.password, isObscure:true),
              SizedBox(
                height: Dimensions.height20,
              ),

              // Nút Dăng ký
              GestureDetector(
                onTap: () {
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor),
                  child: Center(
                    child: BigText(
                      text: "Đăng ký",
                      size: Dimensions.fonts20 + Dimensions.fonts20 / 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: Dimensions.height20,
              ),

              // Tag Line
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: "Đã có tài khoản",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.fonts20))),

              SizedBox(
                height: Dimensions.height20,
              ),

              // Sign Up Options
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: "Đăng ký bằng",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16))),

              Wrap(
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: Dimensions.radius30,
                            backgroundImage: AssetImage(
                                "assets/images/${signUpImage[index]}"),
                          ),
                        )),
              )
            ],
          ),
        ): const CustomerLoader();
      }),
    );
  }
}
