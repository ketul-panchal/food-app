import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // print("i am printing loading state "+Get.find<AuthController>().isLoading.toString());
    return Center(

      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.height20*5,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: AppColors.mainColor,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
