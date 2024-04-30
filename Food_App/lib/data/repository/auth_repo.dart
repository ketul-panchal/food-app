import 'package:food_app/app_constants.dart';
import 'package:food_app/data/api/api_clint.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClint apiClint;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClint,required this.sharedPreferences});

  Future<Response>registration(SignUpBody signUpBody) async {
     return await apiClint.postData(AppConstants.RAGITRATION_URI, signUpBody.toJson());
  }

  Future<Response>login(String email,String password) async {
    return await apiClint.postData(AppConstants.LOGIN_URI, {"phone":email,"password":password});
  }

  Future<bool> saveUserToken(String token) async {
      apiClint.token = token;
      apiClint.updateHeader(token);
      return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  bool userLoggedIn()  {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<void> saveUserNumberAndPassword(String number,String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClint.token='';
    apiClint.updateHeader('');
    return true;
  }
}