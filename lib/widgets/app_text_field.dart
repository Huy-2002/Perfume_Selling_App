import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;

  AppTextField({super.key, required this.textController, required this.hintText, required this.icon, this.isObscure = false});

  @override
  Widget build(BuildContext context) {

    return Container(
                margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.2),
                      )
                    ]
                ),

                child: TextField(
                  obscureText: isObscure? true: false,
                    controller: textController,
                    decoration: InputDecoration(
                        //hintText 
                        hintText: hintText,

                        //prefixIcon
                        prefixIcon: Icon(icon, color: AppColors.yellowColor,),

                        //focusedBorder
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,

                          )
                        ),
                        
                        //enableBorder
                         enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          )
                        ),

                        //Border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          )
                        ),

                    ),
                ),
            );
  }
}