import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/controller/cart_controller.dart';
import 'package:flutter_perfume_application/data/repository/popular_perfume_repo.dart';
import 'package:flutter_perfume_application/model/cart_model.dart';
import 'package:flutter_perfume_application/model/perfume_model.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      //print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;

      update();
    } else {
      print("Mở sever lên bạn ơi");
    }
  }

  // Thanh Toán Giỏ Hàng

  // Tăng giảm số lượng sản phẩm
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  // Tăng và giảm số lượng
  void setQuantity(bool isIncreasement) {
    if (isIncreasement) {
      //print("increasement " + _quantity.toString());

      _quantity = checkQuantity(_quantity + 1);
    } else {
      //print("decreasement " + _quantity.toString());

      _quantity = checkQuantity(_quantity - 1);
    }

    update();
  }

  // Kiểm tra số lượng sản phẩm
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity < 0)) {
      // Thông báo pop up
      Get.snackbar(
        "Thông báo",
        "Bạn không thể bỏ sản phẩm",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      
      if(_inCartItems > 0)
      {
          _quantity = -_inCartItems;
          return _quantity;
      }

      return 0;
    } 
    else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Thông báo",
        "Bạn không thể thêm sản phẩm ",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );

      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = cart.existInCart(product);

    if (exist) {
      _inCartItems = cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    {
      _cart.addItem(product, _quantity);

      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);

      _cart.items.forEach((key, value) {});
    }

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}
