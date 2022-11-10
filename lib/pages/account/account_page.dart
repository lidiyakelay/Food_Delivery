import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage ({Key? key}) : super(key: key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title:  Center(child: BigText(text: "Profile", Size: Dimensions.font12*2,color: Colors.white,)),
          automaticallyImplyLeading:false,
          backgroundColor: AppColors.mainColor,
        ),
        body:GetBuilder<UserController>(builder: (userController){
          return  userLoggedIn?(userController.isLoading?Container(
            margin: EdgeInsets.only(top: Dimensions.height20),
            width: double.maxFinite,
            child: Column(
              children: [
                //profile
                AppIcon(icon: Icons.person,
                  backgroundcolor: AppColors.mainColor,
                  iconcolor: Colors.white,
                  iconSize: Dimensions.height15*5,
                  size: Dimensions.height15*10,
                ),
                SizedBox(height: Dimensions.height30,),
                //name
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                         AccountWidget(icon:AppIcon(icon: Icons.person,
                            backgroundcolor: AppColors.mainColor,
                            iconcolor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ), bigText: BigText(text: userController.userModel.name,)),

                        SizedBox(height: Dimensions.height20,),
                        //phone
                        AccountWidget(icon:AppIcon(icon: Icons.phone,
                          backgroundcolor: AppColors.yellowColor,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ), bigText: BigText(text: userController.userModel.phone ,)),
                        SizedBox(height: Dimensions.height20,),
                        //emaill
                        AccountWidget(icon:AppIcon(icon: Icons.email,
                          backgroundcolor: AppColors.yellowColor,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ), bigText: BigText(text: userController.userModel.email ,)),
                        SizedBox(height: Dimensions.height20,),
                        // address
                        AccountWidget(icon:AppIcon(icon: Icons.location_on,
                          backgroundcolor: AppColors.yellowColor,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ), bigText: BigText(text: 'Adama',)),
                        SizedBox(height: Dimensions.height20,),
                        // message
                        AccountWidget(icon:AppIcon(icon: Icons.message_outlined,
                          backgroundcolor: Colors.redAccent,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ), bigText: BigText(text: 'none',)),
                        SizedBox(height: Dimensions.height20,),

                          GestureDetector(
                            onTap: (){
                              if(Get.find<AuthController>().userLoggedIn()){
                                Get.find<AuthController>().clearSharedData();
                                Get.find<CartController>().clear();
                                Get.find<CartController>().clearHistory();
                                userController.userLoggedOut();
                                userLoggedIn=false;

                              }

                            },
                            child: AccountWidget(icon:AppIcon(icon: Icons.logout,
                              backgroundcolor: Colors.redAccent,
                              iconcolor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ), bigText: BigText(text: 'Log Out',)),
                          )
                        ,
                        SizedBox(height: Dimensions.height20,),
                      ],
                    ),
                  ),
                )





              ],
            ),

          ):CustomLoader()):Container(
            color: Colors.white,
            child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.screenHeight/2.5,
              margin: EdgeInsets.only(left:Dimensions.height20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image:DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/sign_in.JPG")
                  )
              ),
            ),
              SizedBox(height: Dimensions.height20,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.signInPage);
                },
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*3,
                  margin: EdgeInsets.only(left:Dimensions.height20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                     color: AppColors.mainColor,

                  ),
                  child: Center(child: BigText(text: "Sign in",color: Colors.white,Size: Dimensions.font26,)),
                ),
              ),

          ],)
           ,),);
        },)

      ),
    );
  }
}
