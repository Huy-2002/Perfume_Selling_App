import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/data/repository/cart_repo.dart';
import 'package:flutter_perfume_application/model/cart_model.dart';
import 'package:flutter_perfume_application/model/perfume_model.dart';
import 'package:flutter_perfume_application/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {

        totalQuantity = value.quantity! + quantity;

        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
            );
      });

      if(totalQuantity <= 0)
      {
          _items.remove(product.id);
      }

    } else {
      if(quantity > 0)
      {
          _items.putIfAbsent(product.id!, () {
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(), 
            product: product,
            );
      });
      }
      else{
         Get.snackbar
            (
              "Thông báo", "Bạn cần thêm 1 sản phẩm vào giỏ hàng",
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white,
            );
      }
    }

    cartRepo.addtoCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }

    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;

    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }

    return quantity;
  }

  int get totalItems
  {
      var totalQuantity = 0;

      _items.forEach((key, value) {
          totalQuantity = totalQuantity + value.quantity!;  
      });

      return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
       return e.value;
    }).toList();
  }

  int get totalAmount{
    var total = 0;

    _items.forEach((key, value) {
        total += value.quantity! * value.price!;
    });

    return total;
  }

  List<CartModel> storageItems = [];
  List<CartModel> getCartData()
  {
      setCart = cartRepo.getCartList();
      return storageItems;
  }

  set setCart(List<CartModel> items)
  {
      storageItems = items;

      for(int i = 0; i < storageItems.length; i++)
      {
          _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
      }
  }

  void addToHistory()
  {
       cartRepo.addtoCartHistoryList();
       clear();
  }

  void clear()
  {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList()
  {
      return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems)
  {
    _items = {};
    _items = setItems;
  }

  void addtoCartList()
  {
      cartRepo.addtoCartList(getItems);
      update();
  }

// Log Out
  void clearCartHistory()
  {
    cartRepo.clearCartHistory();
    update();
  }
}
