import 'package:flutter/material.dart';
import 'package:optima/screens/auth_screen.dart.dart';
import 'package:optima/screens/item_request_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:optima/screens/AnalyticsOutput.dart';
class AppDrawer extends StatelessWidget {

  final String user;
  AppDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text('Hello there!') ,
        accountEmail: Text("email@email.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            "U",
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
      if(!user.startsWith('s'))
      ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Shop'),
          onTap: () {
            Navigator.of(context).pushNamed('/');
          }),
      if(!user.startsWith('s'))
      ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          }
          ),
          if(!user.startsWith('s'))
      ListTile(
          leading: Icon(Icons.note_add),
          title: Text('Request Item'),
          onTap: () {
            Navigator.of(context).pushNamed(ItemRequestScreen.routeName);
          }
          ),
          if(user.startsWith('s'))
      ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () {
            Navigator.of(context).pushNamed(UserProductsScreen.routeName);
          }),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('View Analytics'),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new LoadFirebaseStorageImage()));
            }),
      ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            Navigator.of(context).pushNamed(AuthScreen.routeName);
            Provider.of<Auth>(context,listen: false).logout();
          }),
    ]
    )
    );
  }
}
