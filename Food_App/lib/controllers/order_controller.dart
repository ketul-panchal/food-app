import 'package:food_app/data/repository/order_repo.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:food_app/models/response_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});

    bool _isLoading = false;
    bool get isLoading => _isLoading;

    int _paymentIndex=0;
    int get paymentIndex => _paymentIndex;

    String _orderType="delivery";
    String get orderType => _orderType;

    String _note = " ";
    String get note => _note;

    Future<void> placeOrder(PlaceOrderBody placeOrder,Function callback) async{
      _isLoading = true;
        Response response = await orderRepo.placeOrder(placeOrder);
        print("my response is ${response.body}");
        if(response.statusCode == 200){
          _isLoading = false;
          String message = response.body['message'];
          String orderID = response.body['order_id'].toString();
          callback(true,message,orderID);
        }else{
          //var responseModel = ResponseModel(false, response.body["errors"][0]["message"],);
          callback(false,response.statusText!,'-1');
        }
    }

    void setPaymentIndex(int index){
      _paymentIndex = index;
      update();
    }

    void setDeliveryType(String type){
      _orderType = type;
      update();
    }

    void setFoodNote(String note){
      _note = note;
    }
}