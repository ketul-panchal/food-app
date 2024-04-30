import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool maxLines;

  AppTextField({Key? key,required this.icon,required this.hintText,required this.textController,this.isObscure=false,
  this.maxLines=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              offset: Offset(1,10),
              color: Colors.grey.withOpacity(0.2),
            )
          ]
      ),
      child: TextField(
        maxLines: maxLines?3:1,
        obscureText: isObscure?true:false,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon,color: AppColors.yellowColor,),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
      ),
    );
  }
}
