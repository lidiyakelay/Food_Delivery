import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  // ignore: non_constant_identifier_names
  PopularFoodDetail ({Key? Key, required this.pageId, required this.page}): super(key: Key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }
  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return
      WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white ,
          body: Stack(
            children: [
              Positioned(
                left: 0,
                  right: 0,
                  child:Container(
                    height: Dimensions.popularFoodImgSize,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BaseUrl+AppConstants.UploadUrl+ product.img!),

                    )
                    ),
                  ) ),
              Positioned(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap:(){
                          if(page=='cartPage'){
                            Get.toNamed(RouteHelper.getCart());
                          }
                          else{
                            Get.toNamed(RouteHelper.getInitial());
                          }

                        },
                        child: AppIcon(icon: Icons.arrow_back_ios_outlined)),
                    GetBuilder<PopularProductController>(builder:(controller){
                      return GestureDetector(
                        onTap: (){
                          if( controller.totalItems>=1){
                          Get.toNamed(RouteHelper.getCart());
                          }
                          //Get.toNamed(RouteHelper.getCart());

                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems>=1?
                               Positioned(
                                   right:0, top:0,
                                   child:
                        AppIcon(icon: Icons.circle, size: 20,backgroundcolor: AppColors.mainColor, iconcolor: Colors.transparent,)):Container(),
                            Get.find<PopularProductController>().totalItems>=1?
                                Positioned(
                                    right:6, top:3,
                                    child: BigText(text: Get.find<PopularProductController>().totalItems.toString(), Size: 12, color: Colors.white,) ) : Container()

                          ],
                        ),
                      );
                    } ),


                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: Dimensions.popularFoodImgSize-20,
                  child:
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                         topLeft: Radius.circular( Dimensions.radius20),
                         topRight: Radius.circular(Dimensions.radius20)),
                      color: Colors.white,
                  ),
                    padding: EdgeInsets.only(left:Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                    AppColumn(text: product.name!),
                      SizedBox(height:Dimensions.height20),
                      BigText(text: 'Introduce'),
                        SizedBox(height:Dimensions.height20),
                        Expanded(
                            child: SingleChildScrollView(
                                child: ExpandableTextWidget(text: product.description!,
                             )
                              ,))

                    ],)),
                  ),

            ],

          ),
          bottomNavigationBar:GetBuilder<PopularProductController>(builder: (popularProduct){
            return  Container(
              height: Dimensions.bottomNavigationHeight,
              padding: EdgeInsets.only(top: Dimensions.height30, bottom:Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20 ),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20*2),
                      topLeft: Radius.circular(Dimensions.radius20*2)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),

                    child: Row(
                      children: [
                        GestureDetector(
                            onTap:(){
                              popularProduct.setQuantity(false);
                            },
                            child: Icon(Icons.remove,color: AppColors.signColor )),
                        SizedBox(width: Dimensions.height10/2,),
                        BigText(text: popularProduct.inCartItem.toString()),
                        SizedBox(width: Dimensions.height10/2,),
                        GestureDetector(
                            onTap:(){
                              popularProduct.setQuantity(true);
                            },
                            child: Icon(Icons.add,color: AppColors.signColor )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      popularProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(text:"\$ ${product.price} | Add to cart", color: Colors.white,),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),

                    ),
                  )
                ],
              ),
            );
          }),

        ),
      );

  }
}
