import 'package:food_app/app_constants.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:get/get.dart';
import 'package:food_app/data/api/api_clint.dart';

class OrderRepo{
  final ApiClint apiClint;
  OrderRepo({required this.apiClint});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClint.postData(AppConstants.PLACE_ORDER_URI,placeOrder.toJson());
  }
}