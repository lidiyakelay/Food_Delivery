import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
//import 'package:food_delivery/routes/roure_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';
import '../../routes/router_helper.dart';

class FoodPageBody extends StatefulWidget {
  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var currPageValue =0.0;
  double scaleFactor= 0.8;
  double height = Dimensions.pageViewContainer;

  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue= pageController.page!;
      });

    });

  }
  @override
  void dispose() {
   pageController.dispose();
   super.dispose();
  }

  @override
  PageController pageController = PageController(viewportFraction: 0.85);
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:Dimensions.height10/2),
      child: Column(
        children: [
          //Slider Section
          GetBuilder<PopularProductController>(builder: (popularProduct){

            return popularProduct.isLoaded?Container(
              height: Dimensions.pageView,

                child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProduct.popularProductList.length,
                    itemBuilder: (context, Position){
                      return _buildPageItem(Position, popularProduct.popularProductList[Position]);
                    }),) : CircularProgressIndicator( color:  AppColors.mainColor,) ;
          }),

          GetBuilder<PopularProductController>(builder: (popularProduct){
            return   DotsIndicator(
              dotsCount: popularProduct.popularProductList.isEmpty?1:popularProduct.popularProductList.length,
              position: currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius5)),
              ),
            );
          }),

          SizedBox(height: Dimensions.height30
            ,),
          //popular txt
          Container(

            margin: EdgeInsets.only(left: Dimensions.width30),
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: 'Recommended'),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText( text: '.', color: Colors.black26,),
                ),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child:
                  SmallText(text: 'Food Pairing',),
                )

              ],
            )
          ),
           //List view
           GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
             return recommendedProduct.isLoaded? ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: recommendedProduct.recommendedProductList.length,
                 itemBuilder:(context, item){
                   return Container(
                       margin: EdgeInsets.only(left: Dimensions.width20, right:Dimensions.width20 , bottom: Dimensions.height10 ),
                       child:Row(
                         children: [
                           //Image Section
                           GestureDetector(
                             onTap:(){
                               Get.toNamed(RouteHelper.getRecommendedProduct(item,'Home'));
                             },
                             child: Container(
                               height:Dimensions.listViewImgSize,
                               width: Dimensions.listViewImgSize,
                               decoration: BoxDecoration(
                                   borderRadius:   BorderRadius.circular(Dimensions.radius20),
                                   color: Colors.white38,
                                   //color: index.isEven?Color(0XFF69c5df):Color(0XFF9492cc),

                                   image: DecorationImage(
                                     fit: BoxFit.cover,
                                       image: NetworkImage(AppConstants.BaseUrl+AppConstants.UploadUrl+ recommendedProduct.recommendedProductList[item].img!),

                                   )
                               ),
                             ),
                           ),
                           //Text Section
                           Expanded(
                             child: Container(
                               height: Dimensions.listViewTxtContSize,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(
                                   topRight:Radius.circular(Dimensions.radius20),
                                   bottomRight:Radius.circular(Dimensions.radius20) ,
                                 ),
                                 color: Colors.white,
                               ),
                               child: Padding(
                                 padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     BigText(text:recommendedProduct.recommendedProductList[item].name!),
                                     SizedBox(height: Dimensions.height10,),
                                     SmallText(text: recommendedProduct.recommendedProductList[item].description!),
                                     SizedBox(height: Dimensions.height10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children:[
                                         IconAndTextWidget(
                                           icon: Icons.circle,
                                           text:'Normal',
                                           iconcolor: AppColors.iconColor1,),

                                         IconAndTextWidget(
                                           icon: Icons.location_on,
                                           text:'1.7km',
                                           iconcolor: AppColors.mainColor,
                                         ),

                                         IconAndTextWidget(
                                           icon: Icons.access_time_rounded,
                                           text:'32min',
                                           iconcolor: AppColors.iconColor2,),
                                         SizedBox(width:5),
                                       ],
                                     )
                                   ],
                                 ),
                               ),

                             ),
                           ),

                         ],
                       )
                   );
                 }): CircularProgressIndicator(color: AppColors.mainColor,);
           },),



        ],
      ),
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==currPageValue.floor()){
      var currScale= 1-(currPageValue-index)*(1-scaleFactor);
      var currTrans= height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);
      //print("currScale 1 "+ currScale.toString());
    }
    else if(index==currPageValue.floor()+1)
    {
      var currScale= scaleFactor+(currPageValue-index+1)*(1-scaleFactor);
      var currTrans= height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);
     // print("currScale 2 "+ currScale.toString());

    }
    else if(index==currPageValue.floor()-1)
    {
      var currScale= 1-(currPageValue-index)*(1-scaleFactor);
      var currTrans= height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);
      // print("currScale 2 "+ currScale.toString());

    }
    else
    {
      var currScale= 0.8;
      var currTrans= height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);
      // print("currScale 2 "+ currScale.toString());

    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
        GestureDetector(

          onTap: (){
    Get.toNamed(RouteHelper.getPopularProduct(index,'Home'));
    },
          child: Container(
          height: Dimensions.pageViewContainer,
          margin: EdgeInsets.only(left: Dimensions.width10, right:Dimensions.width10 ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven?Color(0XFF69c5df):Color(0XFF9492cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(AppConstants.BaseUrl+AppConstants.UploadUrl+ popularProduct.img!),
              )
          ),
      ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right:Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                BoxShadow(
                color: Color(0xFFe8e8e8),
                  offset: Offset(0,5),
                ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0 ),
                    )
                  ],

              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name!),
                    SizedBox(height:Dimensions.height10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(popularProduct.stars!.toInt(), (index) => Icon(Icons.star, color: AppColors.mainColor,
                            size: Dimensions.iconSize15,) )
                          ),
                        SizedBox(width:10),
                        SmallText(text:popularProduct.stars!.toString()),
                        SizedBox(width:10),
                        SmallText(text:'1287'),
                        SizedBox(width:5),
                        SmallText(text:'Comments'),


                      ],
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                      IconAndTextWidget(
                        icon: Icons.circle,
                        text:'Normal',
                        iconcolor: AppColors.iconColor1,),

                        IconAndTextWidget(
                          icon: Icons.location_on,
                          text:'1.7km',
                          iconcolor: AppColors.mainColor,
                        ),

                        IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text:'32min',
                          iconcolor: AppColors.iconColor2,),
                        SizedBox(width:5),
                      ],
                    )
                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );

  }
}
