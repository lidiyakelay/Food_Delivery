import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../models/cart_model.dart';
import '../../routes/router_helper.dart';
import '../../utils/app_constants.dart';

class CartHistory extends StatelessWidget {
  const CartHistory ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return false; //<-- SEE HERE
    }
    var listCounter=0;
    var getCartHistory= Get.find<CartController>().getCartHistory().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();
    for(int i=0; i<getCartHistory.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistory[i].time)){
        cartItemsPerOrder.update(getCartHistory[i].time!, (value) => ++value);
}
      else{
        cartItemsPerOrder.putIfAbsent(getCartHistory[i].time!, () => 1);
}
}
    List<int> cartItemsPerOrderList(){

      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTime(){

      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }
    List<int> itemsPerOrder = cartItemsPerOrderList();
    Widget timeWidget(int index){
      var outputDate= DateTime.now().toString();
      if(index<getCartHistory.length){
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistory[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outPutFormat= DateFormat('MM/dd/yyyy hh:mm a');
        outputDate= outPutFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }


    return WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
      backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                height: Dimensions.height20*5,
                width: double.maxFinite,
                color: AppColors.mainColor,
                padding: EdgeInsets.only(top: Dimensions.height45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigText(text: "Cart history", color: Colors.white,),
                    AppIcon(icon: Icons.shopping_cart_outlined, iconcolor: AppColors.mainColor, backgroundcolor: AppColors.yellowColor,)
                  ],
                ),

              ),
              GetBuilder<CartController>(builder: (cartController){
                return cartController.getCartHistory().length>0? Expanded(child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),
                    child:MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          for(int i=0; i<itemsPerOrder.length; i++)
                            Container(
                              height: Dimensions.height20*6,
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:  MainAxisAlignment.end,
                                children: [
                                  timeWidget(listCounter),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(itemsPerOrder[i], (index) {
                                          if(listCounter<getCartHistory.length){
                                            listCounter++;
                                          }
                                          return index<=2?Container(
                                            margin: EdgeInsets.only(right: Dimensions.width10/2),
                                            height: Dimensions.height20*4,
                                            width: Dimensions.width20*4,
                                            decoration: BoxDecoration(
                                                color: AppColors.mainColor,
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstants.BaseUrl+AppConstants.UploadUrl+ getCartHistory[listCounter-1].img!,

                                                  ),
                                                )
                                            ),
                                          ): Container();
                                        })

                                        ,
                                      ),
                                      Container(
                                        height: Dimensions.height20*4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SmallText(text: 'Total', color: AppColors.titleColor),
                                            BigText(text: itemsPerOrder[i].toString()+'items', color: AppColors.titleColor,),
                                            GestureDetector(
                                              onTap: (){
                                                List<String> orderTime=cartOrderTime();
                                                Map<int, CartModel> moreOrder ={};
                                                for(int j=0; j<getCartHistory.length; j++){
                                                  if(getCartHistory[j].time==orderTime[i]){
                                                    moreOrder.putIfAbsent(getCartHistory[j].id!, () {
                                                      return CartModel.fromJson(jsonDecode(jsonEncode(getCartHistory[j])));
                                                    });
                                                  }
                                                }
                                                Get.find<CartController>().setItems=moreOrder;
                                                Get.find<CartController>().addToCart();
                                                Get.toNamed(RouteHelper.getCart());
                                              } ,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10/2),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius5),
                                                    border: Border.all(color: AppColors.mainColor,width: 1)
                                                ),
                                                child: SmallText(text:'one more', color: AppColors.mainColor,),),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )

                        ],
                      ),
                    )
                )):
                SizedBox(
                  height:MediaQuery.of(context).size.height/1.5,
                  child:const Center(
                     child:NoData(text:"You didn't buy anything so far",
                      imgPath:'assets/images/empty-box.png'),

                  )
                );
    })

            ],
          ),
         ),);
  }
}
