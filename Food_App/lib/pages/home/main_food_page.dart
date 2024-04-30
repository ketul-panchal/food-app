import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Widgets/small_text.dart';
import 'package:food_app/Widgets/text_widgets.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controler.dart';
import 'package:food_app/dimensions.dart';
import 'package:food_app/pages/home/food_page_body.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
      children: [
        //showing the header
        Container(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "India", color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(text: "Gujarat", color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Container(
                  width: Dimensions.height45,
                  height: Dimensions.height45,
                  child: Icon(Icons.search,color: Colors.white, size:Dimensions.iconSize24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        //showing the body
        Expanded(child: SingleChildScrollView(
          child:  FoodPageBody(),
        ))
      ],
    ),
        onRefresh: _loadResources);

  }
}
