import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_perfume_application/controller/popular_perfume_controller.dart';
import 'package:flutter_perfume_application/controller/recommended_perfume_controller.dart';
import 'package:flutter_perfume_application/model/perfume_model.dart';
import 'package:flutter_perfume_application/pages/perfume/popular_perfume_detail.dart';
import 'package:flutter_perfume_application/routes/route_helper.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/app_column.dart';
import 'package:flutter_perfume_application/widgets/big_text.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:flutter_perfume_application/widgets/icon_and_text.dart';
import 'package:flutter_perfume_application/widgets/small_text.dart';
import 'package:get/get.dart';

class PerfumePageBody extends StatefulWidget {
  const PerfumePageBody({super.key});

  @override
  State<PerfumePageBody> createState() => _PerfumePageBodyState();
}

class _PerfumePageBodyState extends State<PerfumePageBody> {
  PageController pageController = PageController(viewportFraction: 1.0);

  // Biến scaling khi kéo slide qua trái và phải
  var curPageValue = 0.0;
  double scaleFactor = 0.8;
  final double _height = Dimensions.pageViewController;

  // Tạo sự kiện kéo trái và phải
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        curPageValue = pageController.page!;

        //print("Current value is " + curPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Section
        GetBuilder<PopularProductController> (builder:(popularProducts)
        {
            return popularProducts.isLoaded ? SizedBox(
          //color: Colors.redAccent,
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: pageController,
            
              // itemCount và position bên trong hàm itemBuilder có liên kết với nhau
              // position trong hàm itemBuilder bắt đầu bằng 0 và kết thúc bằng 4 => itemCount là tổng các index cộng lại trong postion(itemBuilder) => 0,1,2,3,4 là tổng itemCount
              itemCount: popularProducts.popularProductList.length,
            
              // itemBuilder là một hàm truyền vào 2 tham số là context và position (index)
              itemBuilder: (context, position) {
                return _buildPageItem(position, popularProducts.popularProductList[position]);
              },
            ),
         
          ): const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),

        // Dots
       GetBuilder<PopularProductController>(builder: (popularProducts)
       {
          return DotsIndicator(
          dotsCount: popularProducts.popularProductList.isEmpty ?1:popularProducts.popularProductList.length,
          position: curPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        );
       }),




        //Popular text
        SizedBox(
          height: Dimensions.height30,
        ),

        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Dòng nước hoa được đề xuất",color: AppColors.textColor,),
              const SizedBox(
                //width: Dimensions.width10,
              ),

              // Container(
              //   margin: const EdgeInsets.only(bottom: 2),
              //   child: BigText(
              //     text: ".",
              //     color: Colors.black26,
              //   ),
              // ),

              //  SizedBox(width: Dimensions.width10,),

              //  Container(
              //   margin: const EdgeInsets.only(bottom: 2),
              //     child: SmallText(text:"Cặp mùi hương"),
              //  ),
            ],
          ),
        ),


        // Danh sách các dòng nước hoa và hình ảnh
            GetBuilder<RecommendedProductController>(builder: (recommendedProduct)
            {
                return recommendedProduct.isLoaded? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedProductList(index, "home"));
                },

                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      // Image Section
                      Container(
                        width: Dimensions.ListViewImageSize,
                        height: Dimensions.ListViewImageSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius20),
                              bottomLeft: Radius.circular(Dimensions.radius20)),
                          color: Colors.white38,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL+ recommendedProduct.recommendedProductList[index].img!)),
                        ),
                      ),
                
                      // Text Container
                      Expanded(
                        child: Container(
                          height: Dimensions.ListViewTextContSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20)),
                            color: AppColors.proDescription,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                SmallText(text: "Nước hoa lưu hương 5-6 tiếng"),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }) :const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
            })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    // Logic thực hiện hoạt động Carousel
    Matrix4 matrix = Matrix4.identity();
    if (index == curPageValue.floor()) {
      var currScale = 1 - (curPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == curPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (curPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == curPageValue.floor() - 1) {
      var currScale = 1 - (curPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
              // Chuyển đến trang detail khi click vào sản phẩm
            onTap: () {
              Get.toNamed(RouteHelper.getPopularProductList(index, "home"));
            },

            child: Container(
              height: Dimensions.pageViewController,
              // Cách đều hình sản phẩm ra khi trượt
              margin: EdgeInsets.only(
                  left: Dimensions.width30, right: Dimensions.width30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? const Color(0xFF69c5df) : const Color(0xff9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextController,
              // Cách đều hình sản phẩm ra
              margin: EdgeInsets.only(
                  left: Dimensions.width50,
                  right: Dimensions.width50,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),

              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
