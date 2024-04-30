import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Widgets/app_text_field.dart';
import 'package:food_app/Widgets/text_widgets.dart';
import 'package:food_app/base/show_custom_snakbar.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/pages/auth/sign_up_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){

      String  phone = emailController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Type in your email address",title: "Email address");
      //}else if(!GetUtils.isEmail(email)){
      //  showCustomSnackBar("Type in valid email address",title: "Valid Email Address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length < 6){
        showCustomSnackBar("Password can not be less then six character",title: "Password");
      }else{
        showCustomSnackBar("All went well",title: "Perfect");

        //print(signUpBody.toString());
        authController.login(phone,password).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return SingleChildScrollView(
          physics:  BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo2.png"
                    ),
                  ),
                ),
              ),
              //welcome
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello",style: TextStyle(
                        fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        fontWeight: FontWeight.bold
                    ),),
                    Text("Sign into your account",style: TextStyle(
                      fontSize: Dimensions.font20,
                      //fontWeight: FontWeight.bold
                      color: Colors.grey[500],
                    ),)
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //email
              AppTextField(icon: Icons.phone, hintText: "Phone", textController: emailController),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(icon: Icons.password_sharp, hintText: "Password", isObscure: true,textController: passwordController),
              SizedBox(height: Dimensions.height20,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(text: TextSpan(
                      text: "Sign in to your account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,

                      )
                  )),
                  SizedBox(width: Dimensions.width20,),
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign In button
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                      child: BigText(
                        text: "Sign In",size: Dimensions.font20+Dimensions.font20/2,color: Colors.white,)),

                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),

              // SizedBox(height: Dimensions.height10,),
              //tag line

              //sign options
              RichText(text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                        text: " Create",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.font20,
                        ))
                  ]
              )),
            ],
          ),
        );
      },),
    );
  }
}
