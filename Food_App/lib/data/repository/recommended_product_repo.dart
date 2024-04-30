import 'package:food_app/app_constants.dart';
import 'package:food_app/data/api/api_clint.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClint apiClint;
  RecommendedProductRepo({required this.apiClint});

  Future<Response> getRecommendedProductList() async{
    return await apiClint.getData("/api/v1/products/recommended");
  }
}