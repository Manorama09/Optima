import 'package:flutter/material.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text(
          "UserName",
          style: TextStyle(fontSize: 20),
        ),
        accountEmail: Text("email@email.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            "U",
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
      ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Shop'),
          onTap: () {
            Navigator.of(context).pushNamed('/');
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          }
          ),
          Divider(),
      ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () {
            Navigator.of(context).pushNamed(UserProductsScreen.routeName);
          }),
      ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<Auth>(context,listen: false).logout();
          }),
    ]
    )
    );
  }
}
