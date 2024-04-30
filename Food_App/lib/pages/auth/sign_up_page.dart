

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Widgets/app_text_field.dart';
import 'package:food_app/Widgets/text_widgets.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_snakbar.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var singUpImages = [
        "f.png",
        "g.png",
        "t2.png"
    ];
    void _registration(AuthController authController){

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String  email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
          showCustomSnackBar("Type in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title: "Phone Number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address",title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in valid email address",title: "Valid Email Address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length < 6){
        showCustomSnackBar("Password can not be less then six character",title: "Password");
      }else{
        showCustomSnackBar("All went well",title: "Perfect");
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);
        //print(signUpBody.toString());
        authController.registration(signUpBody).then((status){
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
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              //email
              AppTextField(icon: Icons.email, hintText: "Email", textController: emailController),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(icon: Icons.password_sharp, hintText: "Password", isObscure: true,textController: passwordController),
              SizedBox(height: Dimensions.height20,),
              //Name
              AppTextField(icon: Icons.person, hintText: "Name", textController: nameController),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(icon: Icons.phone, hintText: "Phone", textController: phoneController),
              SizedBox(height: Dimensions.height20,),
              //sign up button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
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
                        text: "Sign Up",size: Dimensions.font20+Dimensions.font20/2,color: Colors.white,)),

                ),
              ),
              SizedBox(height: Dimensions.height10,),
              //tag line
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,

                  )
              )),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign options
              RichText(text: TextSpan(
                  text: "Sign Up Using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16,
                  )
              )),
              Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                        "assets/image/"+singUpImages[index],
                      ),
                    ),
                  ))
              )
            ],
          ),
        ):const CustomLoader();
      },),
    );

  }
}
