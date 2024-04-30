import 'package:food_app/app_constants.dart';
import 'package:food_app/data/api/api_clint.dart';
import 'package:food_app/models/address_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
  final ApiClint apiClint;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClint,required this.sharedPreferences});

  String getUserAddress(){
      return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }

  Future<Response> addAddress(AddressModel addressModel) async{
    return await apiClint.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClint.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) async{
    apiClint.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }
}