import 'package:flutter/material.dart';
import './screens/auth_screen.dart.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './providers/auth.dart';
import 'package:optima/screens/Welcome_screen.dart';
import 'screens/auth_screen.dart.dart';

void main() => runApp(MyApp());

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
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'OPTIMA',
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                accentColor: Colors.deepOrange[100],
                fontFamily: 'Lato',
              ),

//                home: WelcomeInit(),
              home: auth.isAuth ? ProductsOverviewScreen() : WelcomeScreen(),
              routes: {
                WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
                AuthScreen.routeName: (ctx) => AuthScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              }),
        ));
  }
}

