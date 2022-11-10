import 'package:get/get.dart';
class Dimensions {
 static double screenHeight = Get.context!.height;
 static double screenWidth = Get.context!.width;
 static double pageView = screenHeight/2.64;
 static double pageViewContainer = screenHeight/3.84;
 static double pageViewTextContainer = screenHeight/7.03;

 //Dynamic height for padding and margin
 static double height10 = screenHeight/84.4;
 static double height20= screenHeight/42.2;
 static double height15= screenHeight/56.27;
 static double height30= screenHeight/28.13;
 static double height45= screenHeight/18.76;


 //Dynamic width for padding and margin
 static double width10 = screenHeight/84.4;
 static double width20= screenHeight/42.2;
 static double width15= screenHeight/56.27;
 static double width30= screenHeight/28.13;
 static double width45= screenHeight/18.76;


//Dynamic font
 static double font20= screenHeight/42.2;
 static double font26= screenHeight/32.46;
 static double font12= screenHeight/70.33;
 static double font16= screenHeight/52.75;

 //Dynamic radius
 static double radius30= screenHeight/28.13;
 static double radius20= screenHeight/42.2;
 static double radius15= screenHeight/56.27;
 static double radius5 = screenHeight/168.8;

 //Dynamic icon size
 static double iconSize24 = screenHeight/35.17;
 static double iconSize15 = screenHeight/56.27;
 static double iconSize16 = screenHeight/52.75;


 //Listviewsize
static double  listViewImgSize= screenWidth/3.25;
static double listViewTxtContSize= screenWidth/3.9;

//popular food
static double popularFoodImgSize = screenHeight/2.41;
//bottomnavigation
static double bottomNavigationHeight = screenHeight/7.03;
// gap between texts
static double textGap = screenHeight/468.89;
// background image in recommended food page
static double backgroungImgSize = screenHeight/2.81;
//splash image
static double spalshImg = screenHeight/3.38;



}