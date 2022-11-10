import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';
import '../data/repository/user_repo.dart';
import '../models/response_model.dart';
class UserController extends GetxController implements GetxService{
  UserRepo userRepo;
  UserController({required this.userRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late UserModel _userModel;
  UserModel get userModel => _userModel;
  Future<ResponseModel>getUserInfo() async {
    Response response =  await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
      print('got here');
      _isLoading=true;
      _userModel= UserModel.fromjson(response.body);
      responseModel=ResponseModel(true, 'successful');
      update();
    }
    else{

      responseModel=ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
  bool userLoggedOut(){
    update();
    return true;
  }
}