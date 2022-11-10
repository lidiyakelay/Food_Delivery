import 'dart:convert';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo( {required this.sharedPreferences});
  List<String>  cart=[];
  List<String> cartHistory=[];
  void addCartList(List<CartModel> cartList){
    //sharedPreferences.remove(AppConstants.cartList);
    //sharedPreferences.remove(AppConstants.cartHistory);
    var time = DateTime.now().toString();
    cart=[];
   cartList.forEach((element) {
     element.time= time;
     return cart.add(jsonEncode(element));});
   sharedPreferences.setStringList(AppConstants.cartList, cart);
   print(cart.toString());


  }
  List<CartModel> getCartList(){
    List<String>  cart=[];
    List<CartModel> cartList=[];
   if(sharedPreferences.containsKey(AppConstants.cartList)){
     cart=sharedPreferences.getStringList(AppConstants.cartList)!;
   }
    cart.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));
   return cartList;

  }
  void addCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.cartHistory)){
      cartHistory=sharedPreferences.getStringList(AppConstants.cartHistory)!;
    }
    for(int i=0; i<cart.length; i++){
      cartHistory.add(cart[i]);
    }

    remove();
    sharedPreferences.setStringList(AppConstants.cartHistory, cartHistory);
    for(int i=0; i<getCartHistory().length; i++){
      print('the time is'+ getCartHistory()[i].time.toString());
    }

  }
  void remove(){
    cart=[];
    sharedPreferences.remove(AppConstants.cartList);
  }
  void clearHistory(){
    cartHistory=[];
    sharedPreferences.remove(AppConstants.cartHistory);
  }
  List<CartModel> getCartHistory(){
    if (sharedPreferences.containsKey(AppConstants.cartHistory)){
      cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstants.cartHistory)!;
    }
    List<CartModel> cartHistoryList=[];
    cartHistory.forEach((element) => cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }

}