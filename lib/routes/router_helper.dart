import 'package:food_delivery/pages/address/add_address_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/popular_food_detail.dart';
import '../pages/home/home_page.dart';
import '../pages/home/main_food_page.dart';

class RouteHelper {
  static const initial = '/';
  static const splash = '/splash';
  static const popularProduct = '/popular-Product';
  static const recommendedProduct = '/recommended-Product';
  static const cart = '/cart';
  static const cartHistory = '/cartHistory';
  static const signInPage = '/signInPage';
  static const addAddressPage = '/addAddressPage';

  static String getInitial() => '$initial';
  static String getSplash() => '$splash';
  static String getPopularProduct(int pageId, String page) => '$popularProduct?pageId=$pageId&page=$page';
  static String getRecommendedProduct(int pageId, String page) => '$recommendedProduct?pageId=$pageId&page=$page';
  static String getCart() => '$cart';
  static String getCartHistory() => '$cartHistory';
  static String getSignInPage() => '$signInPage';
  static String getAddAddressPage() => '$addAddressPage';

  static List<GetPage> routes= [
    GetPage(name : initial, page:()=> HomePage()),
    GetPage(name : splash, page:()=> SplashScreen()),
    GetPage(name : cart, page:(){
      return CartPage();
    },
        transition: Transition.fadeIn
    ),//cartPage
    GetPage(name : cartHistory, page:(){
      return CartHistory();
    },

        transition: Transition.fadeIn
    ),//cartHistoryPage
    GetPage(name : signInPage, page:(){
      return SignInPage();
    },

        transition: Transition.fadeIn
    ),//signinpage
    GetPage(name : popularProduct, page:(){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(  pageId: int.parse(pageId!), page:page!);
    },
    transition: Transition.fadeIn),//popularfoodpage
    GetPage(name : recommendedProduct, page:(){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail( pageId: int.parse(pageId!), page:page!);
    },
         transition: Transition.fadeIn),//recommended food page
    GetPage(name : addAddressPage, page:(){
      return AddAddressPage();
    },
        transition: Transition.fadeIn
    ),//addAddressPage

  ];


}