import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/router_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/small_text.dart';

class  RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  RecommendedFoodDetail({Key? Key, required this.pageId, required this.page}): super(key: Key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }
  @override
  Widget build(BuildContext context) {
    var product= Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
      body: CustomScrollView(
         slivers: [
           SliverAppBar(
             automaticallyImplyLeading: false,
             toolbarHeight: 80,
             title: Row(
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
                     child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined,)
                 GetBuilder<PopularProductController>(builder:(controller){
                   return GestureDetector(
                     onTap: (){
                       if( controller.totalItems>=1){
                         Get.toNamed(RouteHelper.getCart());
                       }
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
             pinned: true,
             bottom: PreferredSize(
               preferredSize: Size.fromHeight(Dimensions.height20),
               child: Container(
                 width: double.maxFinite,
                 padding: EdgeInsets.only(top: 5, bottom: 10,),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(Dimensions.radius20),
                       topRight: Radius.circular(Dimensions.radius20)
                   )
                 ),
                 child: Center(child: BigText(text: product.name!, Size: Dimensions.font26,)),
               ),
             ) ,
           backgroundColor: AppColors.darkYellowColor,
           expandedHeight: Dimensions.backgroungImgSize,
             flexibleSpace:  FlexibleSpaceBar(
           background: Image.network(AppConstants.BaseUrl+AppConstants.UploadUrl+ product.img!,fit: BoxFit.cover,),


             ),

           ),
           SliverToBoxAdapter(

             child: Container(
               margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                 child:  ExpandableTextWidget(text: product.description!,
                 ))

           ),
],
      ),

        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder:(controller){
              return  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width20*2.5, right:Dimensions.width20*2.5 ) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){controller.setQuantity(false);},
                          child: AppIcon(icon: Icons.remove, iconcolor: Colors.white, iconSize: Dimensions.iconSize24, backgroundcolor: AppColors.mainColor,),

                        ),
                        BigText(text: ' \$ ${product.price!}  X '+ controller.inCartItem.toString(), color: AppColors.mainBlackColor, Size: Dimensions.font26,),
                        GestureDetector(
                          onTap: (){controller.setQuantity(true);},
                          child: AppIcon(icon: Icons.add, iconcolor: Colors.white, iconSize: Dimensions.iconSize24, backgroundcolor: AppColors.mainColor,),

                        ),

                      ],
                    ),
                  ),
                  Container(
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

                          child:Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.addItem(product);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                            child: BigText(text:"\$ ${product.price} | Add to cart", color: Colors.white,),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                            ),

                          ) ,
                        ),

                      ],
                    ),
                  ),
                ],
              );
            }
              ,)

      ),
    );
  }
}
