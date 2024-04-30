import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Widgets/text_widgets.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/dimensions.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
      child: Center(child: BigText(text: text, color: Colors.white,)),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0,5),
            blurRadius: 10,
            color: AppColors.mainColor.withOpacity(0.3)
          )
        ],
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(Dimensions.radius20),
      ),
    );
  }
}
