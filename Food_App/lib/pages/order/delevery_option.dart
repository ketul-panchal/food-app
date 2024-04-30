import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOptions({Key? key,required this.value,
    required this.title,required this.amount,required this.isFree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
          children: [
          Radio(value: value, groupValue: orderController.orderType, onChanged: (String? value)=>orderController.setDeliveryType(value!),
      activeColor: AppColors.mainColor,
    ),
        SizedBox(width: Dimensions.width10/2,),
        Text(title, style: TextStyle(fontSize: Dimensions.font20),),
        SizedBox(width: Dimensions.width10/2,),
        Text(
          '(${(value == 'take away'||isFree)?'free':'\$ ${amount/10}'})'
        )
      ],
    );
    });

  }
}
