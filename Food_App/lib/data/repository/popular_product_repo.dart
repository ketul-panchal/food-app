import 'package:food_app/app_constants.dart';
import 'package:food_app/data/api/api_clint.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClint apiClint;
  PopularProductRepo({required this.apiClint});

  Future<Response> getPopularProductList() async{
      return await apiClint.getData("/api/v1/products/popular");
  }
}