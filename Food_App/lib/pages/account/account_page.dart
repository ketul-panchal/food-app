import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Widgets/account_widget.dart';
import 'package:food_app/Widgets/app_icon.dart';
import 'package:food_app/Widgets/text_widgets.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLggedIn){
      Get.find<UserController>().getUserInfo();
      print("User has Logged In");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
            text: "Profile",size: 24,),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLggedIn?(userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),

          child: Column(
            children: [
              AppIcon(icon: Icons.person,backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height30+Dimensions.height45,size: Dimensions.height15*10,),
              SizedBox(height: Dimensions.height30,),

              //name
              Expanded(

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.person,backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,size: Dimensions.height10*5,),
                          bigText: BigText(text: userController.userModel.name)),
                      SizedBox(height: Dimensions.height20,),
                      //telephone
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.phone,backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,size: Dimensions.height10*5,),
                          bigText: BigText(text: userController.userModel.phone)),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.email,backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,size: Dimensions.height10*5,),
                          bigText: BigText(text: userController.userModel.email)),
                      SizedBox(height: Dimensions.height20,),
                      //address
                      GetBuilder<LocationController>(builder: (locationController){
                        if(_userLggedIn&&locationController.addressList.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(
                                appIcon: AppIcon(icon: Icons.location_on,backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,size: Dimensions.height10*5,),
                                bigText: BigText(text: "Fill Your Address",)),
                          );
                        }else{
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(
                                appIcon: AppIcon(icon: Icons.location_on,backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,size: Dimensions.height10*5,),
                                bigText: BigText(text: "Your Address",)),

                          );
                        }
                      }),
                      SizedBox(height: Dimensions.height20,),
                      //message
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.message_outlined,backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,size: Dimensions.height10*5,),
                          bigText: BigText(text: "Messages",)),
                      SizedBox(height: Dimensions.height20,),

                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()) {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }else{
                            print("you logged out");
                          }

                        },
                        child: AccountWidget(
                            appIcon: AppIcon(icon: Icons.logout,backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,size: Dimensions.height10*5,),
                            bigText: BigText(text: "Logout",)),
                      ),
                      SizedBox(height: Dimensions.height20,),

                    ],
                  ),
                ),
              )
            ],
          ),
        ):
        CustomLoader()):
        Container(child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height20*14,
              margin: EdgeInsets.only(left: Dimensions.width30*2,right: Dimensions.width30*2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/image/signin.png"
                      )
                  )
              ),
            ),
            GestureDetector(

              onTap: (){
                Get.toNamed(RouteHelper.getSignInPage());
              },
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20*5,
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),

                ),
                child: Center(child: BigText(text: "Sign In",color: Colors.white,size: Dimensions.font26,)),
              ),
            )
          ],
        )),);
      },),
    );
  }
}
