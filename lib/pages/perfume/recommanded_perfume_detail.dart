import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/controller/cart_controller.dart';
import 'package:flutter_perfume_application/controller/popular_perfume_controller.dart';
import 'package:flutter_perfume_application/controller/recommended_perfume_controller.dart';
import 'package:flutter_perfume_application/pages/cart/cart_page.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/app_icons.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:flutter_perfume_application/widgets/expandable_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecommandedPerfumeDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommandedPerfumeDetail({required this.pageId, super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    final NumberFormat currencyFormat = NumberFormat("#,##0", "en_US");

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == "cartpage") {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: AppIcon(icons: Icons.clear),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icons: Icons.shopping_cart_outlined,
                          ),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icons: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 5,
                                  top: 2,
                                  child: BigText(
                                    text: controller.totalItems.toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ))
                              : Container()
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius15)),
                ),
                child: Center(
                  child: BigText(size: Dimensions.fonts26, text: product.name!),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableText(text: product.description!),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icons: Icons.remove),
                  ),
                  BigText(
                    text: "${currencyFormat.format(product.price!)} X  ${controller.inCartItems}",
                    color: AppColors.mainBlackColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icons: Icons.add),
                  )
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: BigText(
                        text: "Thêm vào giỏ hàng",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
