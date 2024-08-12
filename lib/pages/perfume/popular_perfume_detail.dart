import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_perfume_application/controller/cart_controller.dart';
import 'package:flutter_perfume_application/controller/popular_perfume_controller.dart';
import 'package:flutter_perfume_application/pages/cart/cart_page.dart';
import 'package:flutter_perfume_application/pages/home/main_perfume_page.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/app_column.dart';
import 'package:flutter_perfume_application/widgets/app_icons.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:flutter_perfume_application/widgets/expandable_text.dart';
import 'package:flutter_perfume_application/widgets/icon_and_text.dart';
import 'package:flutter_perfume_application/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularPerfumeDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const PopularPerfumeDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    //print("page id is " + pageId.toString());
    //print("product name is " + product.name.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularPerfumeImageSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),

          // Icon Widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Chuyển qua lại giữa các trang
                  GestureDetector(
                      onTap: () {

                        if(page == "cartpage")
                        {
                            Get.toNamed(RouteHelper.getCartPage());
                        }
                        else{
                            Get.toNamed(RouteHelper.getInitial());
                        }

                      },
                      child: AppIcon(icons: Icons.arrow_back_ios)),

                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(

                        onTap: (){
                          if(controller.totalItems >= 1)
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
                        
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 5,
                                    top: 2,
                                    child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
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
              )),

          // Introduction of perfume
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularPerfumeImageSize - 50,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),

                // Product Description
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "Giới thiệu sản phẩm"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableText(text: product.description!)))
                  ],
                ),
              )),
        ],
      ),
      
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
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
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          )),

                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),

                      BigText(text: popularProduct.inCartItems.toString()),

                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),

                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          )),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                      popularProduct.addItem(product);
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
