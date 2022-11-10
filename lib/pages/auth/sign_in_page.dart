import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signin_body_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    var phoneController= TextEditingController();
    var passwordController= TextEditingController();
    void login(AuthController authController){
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackbar('Type in your phone', title: 'Phone');
      }
      else if(password.isEmail){
        showCustomSnackbar('Type in your password', title: 'Password');
      }
      else if(password.length<6){
        showCustomSnackbar("Password can't be less than six characters", title: 'Password');
      }

      else{
        SignInBody signInBody= SignInBody(phone: phone, password: password,);
        authController.login(signInBody).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }
          else{
            showCustomSnackbar(status.message);
          }
        });
      }


    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body:GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                //App Logo
                Container(
                  height: Dimensions.screenHeight*0.25,
                  margin:  EdgeInsets.only(top: Dimensions.screenHeight*0.05),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius:Dimensions.radius20*4 ,
                      backgroundImage: AssetImage('assets/images/logo-1.png'),
                    ),
                  ),
                ),
                //Hello text
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello',
                        style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font20*3.5,
                            fontWeight: FontWeight.bold
                        ),),
                      Text('Sign into your account',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,

                        ),)
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                //phoneNumber
                AppTextField(textEditingController: phoneController, hintText: 'Phone', iconData: Icons.phone,iconcolor: AppColors.mainColor,),
                SizedBox(height: Dimensions.height20,),
                //Password
                AppTextField(textEditingController: passwordController, hintText: 'Password', iconData: Icons.password_sharp,iconcolor: AppColors.mainColor,isObsecure:true),
                SizedBox(height: Dimensions.height30,),
                //sign in text
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[Text('Sign into your account',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,

                      ),),
                      SizedBox(width: Dimensions.width20,),

                    ]
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //Sign up Button
                GestureDetector(
                  onTap:() {login(authController);},
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,

                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius30)
                    ),
                    child: Center(child: BigText(text: 'Sign in', color: Colors.white,Size: Dimensions.font20*1.5,)),
                  ),
                ),

                SizedBox(height:Dimensions.screenHeight*0.05,),
                //create account txt
                RichText(
                  text: TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,

                      ), children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpPage(), transition: Transition.fade),
                        text: ' Create',
                        style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold
                        )
                    )
                  ]

                  ),
                ),



              ],
            ),
          ):CustomLoader();
        })
       ,
      ),
    );
  }
}
