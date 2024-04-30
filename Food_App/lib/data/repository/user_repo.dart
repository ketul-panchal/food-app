import 'package:food_app/app_constants.dart';
import 'package:food_app/data/api/api_clint.dart';
import 'package:get/get.dart';

class UserRepo{
  final ApiClint apiClint;
  UserRepo({required this.apiClint});

  Future<Response> getUserInfo() async {
    return await apiClint.getData(AppConstants.USER_INFO_URI);
  }
}