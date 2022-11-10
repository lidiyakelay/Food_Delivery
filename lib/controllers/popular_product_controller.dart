import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
 final PopularProductRepo popularProductRepo;
 PopularProductController ({required this.popularProductRepo});
  List <dynamic> _popularProductList = [];
  List <dynamic> get popularProductList =>  _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded=> _isLoaded;
  int _quantity=0;
  int _inCartItem=0;
  int get quantity=> _quantity;
  int get inCartItem=> _inCartItem + _quantity;
  late CartController _cart;
  Future <void> getPopularProductList() async {
    Response response =  await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      _popularProductList= [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();

    }

    else{
      print('did not get product');
    }
 }

 void setQuantity (bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);
     // print('in cart item is here '+_inCartItem.toString());
    }
    else{
      _quantity=checkQuantity(_quantity-1);
    //  print('in cart item is '+_inCartItem.toString());
    }
     update() ;
 }
 int checkQuantity(int quantity){
    if(_inCartItem+quantity<0){
      Get.snackbar('Item Count', 'You can\'t reduce more item!',
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
      if(_inCartItem >0){
        return _quantity= -_inCartItem;
      }
      return 0;
    }
    else if(_inCartItem+quantity>20){
      Get.snackbar('Item Count', 'You can\'t add more item!',
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      return 20;
    }
    else{
      return quantity;
    }
 }
 void initProduct(ProductModel product,CartController cart){
    _quantity=0;
    _inCartItem=0;
    _cart=cart;
    var exist= false;
    exist= cart.existInCart(product);
    if(exist){
      _inCartItem=cart.getQuantity(product);

    }

 }
 void addItem(ProductModel product){

      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItem=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print('the id is'+ value.id.toString()+ 'the quantity is'+ value.quantity.toString()  );
      });
update();
 }
  int get  totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}