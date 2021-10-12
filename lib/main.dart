import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_adminpage/provider/order.dart';
import 'package:shopping_adminpage/provider/product.dart';
import 'package:shopping_adminpage/screens/editProductScreen.dart';
import 'package:shopping_adminpage/screens/fullDetailOrder.dart';
import 'package:shopping_adminpage/screens/homePage.dart';
import 'package:shopping_adminpage/screens/productDetaiilScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=>Products()),
        ChangeNotifierProvider(create: (ctx)=>Orders()),
      ],

      child: MaterialApp(
          title: "Admin Page",
          home: HomePage(),
          routes: {
            EditProductScreen.routerName:(ctx)=>EditProductScreen(),
            UserProductScreen.routerName:(ctx)=>UserProductScreen(),
            OrderDetails.routerName:(ctx)=>OrderDetails(),
          },
        ),
    );

  }
}

