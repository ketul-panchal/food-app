import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/response_model.dart';
import 'package:get/get.dart';

class LocationController extends GetxController implements GetxService{
    LocationRepo locationRepo;
    LocationController({required this.locationRepo});
    bool _loading = false;
    //late Position _position;
    //late Position _pickPosition;
    //Placemark _placemark = Placemark();
    //Placemark _pickPlacemark = Placemark();

    List<AddressModel> _addressList =[];

    List<AddressModel> get addressList=> _addressList;

    late List<AddressModel> _allAddressList;
    List<AddressModel> get allAddressList => _allAddressList;
    final List<String> _addressTypeList=["home","office","others"];
    List<String> get addressTypeList => _addressTypeList;
    int _addressTypeIndex = 0;
    int get addressTypeIndex => _addressTypeIndex;

    late Map<String,dynamic> _getAddress;
    Map get getAddress => _getAddress;
    AddressModel getUserAddress(){
        late AddressModel _addressModel;
        /*
         converting to map using jasonDecode
         */
        _getAddress = jsonDecode(locationRepo.getUserAddress());
        try{
            _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
        }catch(e){
            print(e);
        }
        return _addressModel;
    }
    void setAddressTypeIndex(int index){
        _addressTypeIndex = index;
        update();
    }

    Future<ResponseModel> addAddress(AddressModel addressModel) async {
        _loading = true;
        update();
        Response response = await locationRepo.addAddress(addressModel);
        ResponseModel responseModel;
        if(response.statusCode == 200){
            await getAddressList();
            String message = response.body["message"];
            responseModel = ResponseModel(true, message);
            await saveUserAddress(addressModel);
        }else{
            print("Couldn't save the address");
            responseModel = ResponseModel(false, response.statusText!);
        }
        update();
        return responseModel;
    }

    Future<void> getAddressList() async {
        Response response = await locationRepo.getAllAddress();
        if(response.statusCode == 200){
            _allAddressList=[];
            _addressList=[];
            response.body.forEach((address){
               _addressList.add(AddressModel.fromJson(address));
               _allAddressList.add(AddressModel.fromJson(address));
            });
        }else{
            _allAddressList=[];
            _addressList=[];
        }
        update();
    }

    Future<bool> saveUserAddress(AddressModel addressModel) async {
        String userAddress = jsonEncode(addressModel.toJson());
        return await locationRepo.saveUserAddress(userAddress);
    }
}