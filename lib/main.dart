import 'package:flutter/material.dart';
import 'package:optima/screens/item_request_screen.dart';
import 'package:provider/provider.dart';

import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './providers/auth.dart';
import './screens/welcome_screen.dart';
import './providers/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders)
            => Orders(
              auth.token,
              auth.userId,
              previousOrders == null
              ? []
              : previousOrders.orders
              ),
          ),
          // ChangeNotifierProxyProvider<Auth, Users>(
          //   update: (ctx, auth, previousUsers) 
          //   => Users(
          //       auth.token,
          //       auth.userId,
          //       previousUsers == null ? [] : previousUsers.users),
          // ),
          // ChangeNotifierProvider(
          //   create: (ctx) => User(),
          // ),
          ChangeNotifierProvider(
            create: (ctx) => Item(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'OPTIMA',
              theme: ThemeData(
                primaryColor: Color(0xff075E54),
                accentColor: Colors.blueGrey,
                fontFamily: 'lineto',
              ),

              home: auth.isAuth ? ProductsOverviewScreen() : WelcomeScreen(),
              routes: {
                ItemRequestScreen.routeName:(ctx) => ItemRequestScreen(),
                WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
                AuthScreen.routeName: (ctx) => AuthScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              }),
        ));
  }
}

