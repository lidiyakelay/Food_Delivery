import 'package:food_delivery/data/repository/auth_repo.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';
import '../models/signin_body_model.dart';

class AuthController extends GetxController implements GetxService{
  AuthRepo authRepo;
 AuthController({required this.authRepo});
 bool _isLoading = false;
 bool get isLoading => _isLoading;
 Future<ResponseModel>registration(SignUpBody signUpBody) async {
     _isLoading=true;
     update();
     Response response =  await authRepo.registration(signUpBody);
     late ResponseModel responseModel;
     if(response.statusCode==200){
       print('success'+response.body['token']);
      authRepo.saveToken(response.body['token']);
      responseModel=ResponseModel(true, response.body['token']);
     }
    else{
      print('fail');
      responseModel=ResponseModel(false, response.statusText!);
     }
    _isLoading=false;
    update();
    return responseModel;
}
 Future<ResponseModel>login(SignInBody signInBody) async {
   _isLoading=true;
   update();
   Response response =  await authRepo.login(signInBody);
   late ResponseModel responseModel;
   if(response.statusCode==200){
     print('got here');
     authRepo.saveToken(response.body['token']);
     responseModel=ResponseModel(true, response.body['token']);
   }
   else{
     print('got here 2');
     responseModel=ResponseModel(false, response.statusText!);
   }
   _isLoading=false;
   update();
   return responseModel;
 }

 saveUserCredentials(SignInBody signInBody){
   authRepo.saveUserCredentials(signInBody);
 }
 bool userLoggedIn(){
   return authRepo.userLoggedIn();
 }
 bool clearSharedData(){
   return authRepo.clearSharedData();
 }

}