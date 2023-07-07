import 'package:flutter/material.dart';
import 'package:kvn11mart/View/ProductListScreen.dart';
import 'package:kvn11mart/View/cartScreen.dart';
import 'Routes_name.dart';
import 'SplashScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.splashScreen:
        {
          return MaterialPageRoute(builder: (context) => SplashScreen());
        }
      case RoutesName.productList:
        {
          return MaterialPageRoute(builder: (context) => ProductListScreen());
        }
      case RoutesName.CartScreen:
        {
          return MaterialPageRoute(builder: (context) => CartScreen());
        }

      default:
        {
          return MaterialPageRoute(
              builder: (context) => Scaffold(
                      body: Center(
                    child: Text("No route defined"),
                  )));
        }
    }
  }
}

