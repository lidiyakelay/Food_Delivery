import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signin_body_model.dart';
import '../../models/signup_body_model.dart';

class AuthRepo{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.post(AppConstants.RegisterUrl, signUpBody.toJson());
  }
  Future<Response> login(SignInBody signInBody) async {
    return await apiClient.post(AppConstants.LoginUrl, signInBody.toJson());
  }
  Future<bool> saveToken(String token) async{
    apiClient.token=token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.Token, token);
  }
  Future<void> saveUserCredentials(SignInBody signInBody) async{
    try{
      await sharedPreferences.setString(AppConstants.userPhone, signInBody.phone);
      await sharedPreferences.setString(AppConstants.password, signInBody.password);
    }
    catch(e){
      throw e;
    }

  }
  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.Token);
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.Token);
    sharedPreferences.remove(AppConstants.password);
    sharedPreferences.remove(AppConstants.userPhone);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }


}