import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/controller/popular_perfume_controller.dart';
import 'package:flutter_perfume_application/controller/recommended_perfume_controller.dart';
import 'package:flutter_perfume_application/pages/home/perfume_page_body.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:flutter_perfume_application/widgets/small_text.dart';
import 'package:get/get.dart';

class PerfumeMainPage extends StatefulWidget {
  const PerfumeMainPage({super.key});

  @override
  State<PerfumeMainPage> createState() => _PerfumeMainPageState();
}

class _PerfumeMainPageState extends State<PerfumeMainPage> {
  Future<void> _loadResources() async {
    // Get Data From Laravel
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    // Check chiều cao của máy ảo hiện tại
    //print(" The current height is ${MediaQuery.of(context).size.height}");

    return RefreshIndicator(
        onRefresh: _loadResources,
        child: Column(
          children: [
            // Showing The Header
            Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height80, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "Việt Nam",
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Thành phố Hồ Chí Minh",
                              color: AppColors.textColor,
                            ),
                            const Icon(Icons.arrow_drop_down_rounded,color: AppColors.iconColor2,)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //Showing The Body
            const Expanded(
              child: SingleChildScrollView(
                child: PerfumePageBody(),
              ),
            )
          ],
        ));
  }
}
