import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controler.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/pages/auth/sign_up_page.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/food/recommended_food_datail.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/splash/spalsh_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'helper/dependancies.dart' as dep;
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: SignInPage(),
          // home: MainFoodPage(),
          // CartPage(),
          // MainFoodPage(), // 1st page
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          // PopularFoodDetail(),  2nd page
          //  RecommendedFoodDetail(),
        );
      });
    },);
  }
}

