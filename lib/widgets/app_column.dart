import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:flutter_perfume_application/widgets/icon_and_text.dart';
import 'package:flutter_perfume_application/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: text, size: Dimensions.fonts26,),

                      SizedBox(height: Dimensions.height10),

                      // Comment and star section
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: 15,
                                    )),
                          ),
                          SizedBox(width: 10),
                          SmallText(text: "4.5"),
                          SizedBox(width: 10),
                          SmallText(text: "1500 comments")
                        ],
                      ),

                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      // Time and Distance section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(
                              icon: Icons.circle_sharp,
                              text: "Normal",
                              iconColor: AppColors.iconColor1),
                          IconAndText(
                              icon: Icons.location_on,
                              text: "1.5km",
                              iconColor: AppColors.mainColor),
                          IconAndText(
                              icon: Icons.access_time_rounded,
                              text: "32min",
                              iconColor: AppColors.iconColor2),
                        ],
                      )
                    ]);
  }
}