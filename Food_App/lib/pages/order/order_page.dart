import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/dimensions.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn =  Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController = TabController(length: 2, vsync: this);
      //Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: [
                  Tab(text: "Current",),
                  Tab(text: "History",),
            ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children:[
                  Text("order 1"),
                  Text("order 2"),
            ]),
          )
        ],
      )
    );
  }
}
