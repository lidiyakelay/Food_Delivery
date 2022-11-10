import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../base/no_data_page.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/app_constants.dart';

class CartPage extends StatelessWidget {

  // ignore: non_constant_identifier_names
  CartPage({Key? Key}): super(key: Key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20*2,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();

                    },
                    child: AppIcon(icon: Icons.arrow_back_ios_outlined, iconSize:Dimensions.iconSize24,
                      backgroundcolor: AppColors.mainColor,
                      iconcolor: Colors.white,),
                  ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined, iconSize: Dimensions.iconSize24,
                      backgroundcolor: AppColors.mainColor,
                      iconcolor: Colors.white,),
                  ),
                  AppIcon(icon: Icons.shopping_cart_sharp, iconSize:  Dimensions.iconSize24,
                    backgroundcolor: AppColors.mainColor,
                    iconcolor: Colors.white,),

                ],
              )
            ),
        GetBuilder<CartController>(builder: (cartController){
          return cartController.getItems.length>0? Positioned(
            top: Dimensions.height20*5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_,index){
                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.height20*5,
                            margin: EdgeInsets.only(top: Dimensions.height15 ),
                            //color: Colors.lightBlueAccent,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){

                                    var popularIndex= Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product);

                                    if(popularIndex>=0){

                                      Get.toNamed(RouteHelper.getPopularProduct(popularIndex,'cartPage'));


                                    }
                                    else{
                                      var recomendedIndex= Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product);
                                      if(recomendedIndex<0){
                                        Get.snackbar("History Product","Product review isn't available for history product",
                                            backgroundColor: AppColors.mainColor,
                                            colorText: Colors.white);
                                      }
                                      else{
                                        Get.toNamed(RouteHelper.getRecommendedProduct(recomendedIndex, 'cartPage'));

                                      }


                                    }
                                  },
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    width: Dimensions.width20*5 ,
                                    margin: EdgeInsets.only(top: Dimensions.height10 ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: AppColors.mainColor,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(AppConstants.BaseUrl+AppConstants.UploadUrl+_cartList[index].img! ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: _cartList[index].name!, color: Colors.black54,),
                                        SmallText(text: 'Spicy'),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: '\$ '+ _cartList[index].price.toString(), color: Colors.black54),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              ),

                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap:(){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(Icons.remove,color: AppColors.signColor )),
                                                  SizedBox(width: Dimensions.height10/2,),
                                                  BigText(text:cartController.getItems[index].quantity.toString() ),//popularProduct.inCartItem.toString()),
                                                  SizedBox(width: Dimensions.height10/2,),
                                                  GestureDetector(
                                                      onTap:(){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                      },
                                                      child: Icon(Icons.add,color: AppColors.signColor )),
                                                ],
                                              ),
                                            ),
                                          ],)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },)
                  ,
                )
            ),
          ): NoData(text:"Your cart is empty!", imgPath: 'assets/images/empty_cart.JPG');
        })

             ,

          ],
        ),
        bottomNavigationBar:GetBuilder<CartController>(builder: (cartController){
          return  Container(
            height: Dimensions.bottomNavigationHeight,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom:Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20 ),
            decoration: BoxDecoration(
                color: cartController.getItems.length>0?AppColors.buttonBackgroundColor:Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20*2),
                    topLeft: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child:  cartController.getItems.length>0? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),

                  child: BigText(text:cartController.totalAmount.toString()),


                ),
                GestureDetector(
                  onTap: (){
                    if(Get.find<AuthController>().userLoggedIn()&& Get.find<UserController>().isLoading){
                      if(Get.find<LocationController>().addressList.isEmpty){
                         Get.toNamed(RouteHelper.getAddAddressPage());
                      }
                     // cartController.addToHistory();
                    }
                    else{
                      Get.toNamed(RouteHelper.getSignInPage());
                    }


                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    child: BigText(text:"Check Out", color: Colors.white,),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),

                  ),
                )
              ],
            ):Container(),
          );
        }),




      ),
    );
  }
}