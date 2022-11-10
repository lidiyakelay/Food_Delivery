import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
  baseUrl=appBaseUrl;
    timeout= Duration(seconds: 30);
    token=sharedPreferences.getString(AppConstants.Token)??"";
    _mainHeaders={
      'Content-type': 'application/json; Charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  updateHeader(String token){
    _mainHeaders={
      'Content-type': 'application/json; Charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  Future<Response> getData(String uri,{ Map<String, String>? headers}) async{
    try{
     Response response= await get(uri, headers:headers??_mainHeaders) ;
     return response;
    }
    catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  Future<Response> postData(String uri, dynamic data)async{
    try{
      Response response = await post(uri, data,headers:_mainHeaders);
      return response;
    }
    catch(e){
      return Response(statusCode: 1,statusText:e.toString());
    }
  }
}