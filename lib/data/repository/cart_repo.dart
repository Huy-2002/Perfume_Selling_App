import 'dart:convert';

import 'package:flutter_perfume_application/model/cart_model.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
    final SharedPreferences sharedPreferences;
    CartRepo({required this.sharedPreferences});

    List<String> cart = [];
    
    
    // Chuyển dữ liệu từ controller qua
    void addtoCartList(List<CartModel> cartList)
    {
        // Giữ nguyên hoặc xóa lịch sử đơn hàng
        sharedPreferences.remove(AppConstants.CART_LIST);
        sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);

        var time = DateTime.now().toString();
        cart = [];

        cartList.forEach((element) {
          element.time = time;
          return cart.add(jsonEncode(element)); // element là kiểu dữ liệu string được chuyển từ object
        });

        // sharedPreferences chỉ chấp nhận kiểu dữ liệu dạng string
        sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
        //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
        getCartList();
    }

    List<CartModel> getCartList()
    {
        List<String> carts = [];

        if(sharedPreferences.containsKey(AppConstants.CART_LIST))
        {
          carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
          print("inside GetCartList" + carts.toString());
        }

        List<CartModel> cartList = [];

        carts.forEach((element) {
            return cartList.add(CartModel.fromJson(jsonDecode(element)));
        });

        return cartList;
    }

    List<CartModel> getCartHistoryList()
    {
        if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST))
        {
            cartHistory = [];
            cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
        }

        List<CartModel> cartListHistory = [];
        cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
        return cartListHistory;
    }

    List<String> cartHistory = [];

    void addtoCartHistoryList()
    {
      if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST))
      {
          cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
      }

      for(int i = 0; i < cart.length; i++)
      {
          cartHistory.add(cart[i]);
      }
      removeCart();
      sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
      //print("The length of history list is " + getCartHistoryList().length.toString());

      for(int i = 0; i <getCartHistoryList().length; i++)
      {
          print("The time for the order is " + getCartHistoryList()[i].time.toString());
      }
    }

    void removeCart()
    {
         cart = [];
         sharedPreferences.remove(AppConstants.CART_LIST);

    }

    // Log Out
    void clearCartHistory()
    {
      removeCart();
      cartHistory=[];
      sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    }
}