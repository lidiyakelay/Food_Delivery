import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/router_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    var singUpOptions= ['g.png','t.png', 'f.png'];


    var emailController= TextEditingController();
    var phoneController= TextEditingController();
    var passwordController= TextEditingController();
    var nameController= TextEditingController();
    void registration(AuthController  authController){
      String email= emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      String name= nameController.text.trim();
      if(email.isEmpty){
        showCustomSnackbar('Type in your email address', title: 'Email');
      }
      else if(!GetUtils.isEmail(email)){
        showCustomSnackbar('Type in valid email address', title: 'Email');
      }
      else if(password.isEmail){
        showCustomSnackbar('Type in your password', title: 'Password');
      }
      else if(password.length<6){
        showCustomSnackbar("Password can't be less than six characters", title: 'Password');
      }
      else if(name.isEmpty){
        showCustomSnackbar('Type in your name', title: 'Name');
      }
      else if(phone.isEmpty){
        showCustomSnackbar('Type in your phone', title: 'Phone');
      }
      else{
        SignUpBody signUpBody= SignUpBody(email: email, password: password, name: name, phone: phone);
        authController.registration(signUpBody).then((status){
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
        body: GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
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
                //Emaill
                AppTextField(textEditingController: emailController, hintText: 'Email', iconData: Icons.email,iconcolor: AppColors.mainColor,),
                SizedBox(height: Dimensions.height20,),
                //Password
                AppTextField(textEditingController: passwordController, hintText: 'Password', iconData: Icons.password_sharp,iconcolor: AppColors.mainColor, isObsecure: true,),
                SizedBox(height: Dimensions.height20,),
                //Phone
                AppTextField(textEditingController: phoneController, hintText: 'Phone', iconData: Icons.phone,iconcolor: AppColors.mainColor),
                SizedBox(height: Dimensions.height20,),
                //Name
                AppTextField(textEditingController: nameController, hintText: 'Name', iconData: Icons.person,),
                SizedBox(height: Dimensions.height20,),
                // Sign up button
                GestureDetector(
                  onTap: (){
                    registration(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,

                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius30)
                    ),
                    child: Center(child: BigText(text: 'Sign Up', color: Colors.white,Size: Dimensions.font20*1.5,)),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                //Hve an account?
                RichText(
                  text: TextSpan(
                      text: "Have an account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,

                      ), children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignInPage(),transition: Transition.fade),
                        text: ' Sign in',
                        style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold
                        )
                    )
                  ]

                  ),

                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //signup options
                RichText(
                  text: TextSpan(
                      text: "Sign up using one  of the following options",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16,

                      )
                  ),

                ),
                //signup options
                Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(singUpOptions.length,(index) => Padding(

                    padding: EdgeInsets.all(Dimensions.height10),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage('assets/images/'+singUpOptions[index]),
                    ),
                  ),

                  ),
                )


              ],
            ),
          ):CustomLoader();
        },)

      ),
    );
  }
}
