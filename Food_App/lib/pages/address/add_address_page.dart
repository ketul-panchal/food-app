import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Widgets/app_icon.dart';
import 'package:food_app/Widgets/app_text_field.dart';
import 'package:food_app/Widgets/text_widgets.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/models/address_model.dart';
import 'package:get/get.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  //CameraPosition _cameraPosition = const CameraPosition(target : LatLng(
  //  45.51563, -122.667433
  // ),zoom: 17);

  //late LatLng _initialPosition;

  @override
   void initState() {
  //    TODO: implement initState
     super.initState();
     _isLogged = Get.find<AuthController>().userLoggedIn();
      if(_isLogged){
        Get.find<UserController>().getUserInfo();
      }
  //
  //    // if(Get.find<LocationController>().addressList.isNotEmpty){
  //    //   //_cameraPosition=CameraPosition(target: LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
  //    //   // double.parse(LatLng(Get.find<LocationController>().getAddress["langitude"]))
  //    //   // ));
  //    //      _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
  //    //     //   // double.parse(LatLng(Get.find<LocationController>().getAddress["langitude"]))
  //    //     //   // )
  //    // }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
                 _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){

          return SingleChildScrollView(

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding:EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height10),
                  child: SizedBox(height: 50,child: ListView.builder(
                      itemCount: locationController.addressTypeList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height10),
                            margin: EdgeInsets.only(right: Dimensions.width10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    spreadRadius: 1,
                                    blurRadius: 5,

                                  )
                                ]
                            ),
                            child: Icon(
                              index==0?Icons.home:index==1?Icons.work:Icons.location_on,
                              color: locationController.addressTypeIndex==index?AppColors.mainColor:Theme.of(context).disabledColor,
                            )
                          ),
                        );
                      }),),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address",),),
                SizedBox(height: Dimensions.height10,),
                AppTextField(icon: Icons.map, hintText: "Your Address", textController: _addressController),
                SizedBox(height: Dimensions.height20,),
                Padding(padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Name",),),
                SizedBox(height: Dimensions.height10,),
                AppTextField(icon: Icons.person, hintText: "Your Name", textController: _contactPersonName),
                SizedBox(height: Dimensions.height20,),
                Padding(padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Name",),),
                SizedBox(height: Dimensions.height10,),
                AppTextField(icon: Icons.phone, hintText: "Your Number", textController: _contactPersonNumber),
              ],
            ),
          );
        });
      },),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height20*8,
              padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20*2),
                      topRight: Radius.circular(Dimensions.radius20*2)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                        AddressModel _addressModel = AddressModel(addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                        );
                        locationController.addAddress(_addressModel).then((response){
                          if(response.isSuccess){
                            Get.back();
                            Get.snackbar("Address", "Added Successfully");
                          }else{
                            Get.snackbar("Address", "Couldn't Save Address");
                          }
                        });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                      child: BigText(text: "Save Address", color: Colors.white,size: 26,),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        );
      },),
    );
  }
}
