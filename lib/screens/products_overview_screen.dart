import 'package:flutter/material.dart';
import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:provider/provider.dart';

import '../widgets/chatbot.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_list.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../providers/products.dart';
import '../providers/auth.dart';


enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
static const routeName = '/products_overview_screen';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  bool accepted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  AppBar getAppBar(BuildContext ctx) {
    final authData = Provider.of<Auth>(ctx);
    return AppBar(
      title: Text('Shop', 
      style: TextStyle(
      color: Colors.black87,
      fontFamily: "lineto",
      fontWeight: FontWeight.w300
      ),),
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.grey),
      actions: authData.seller? null : <Widget>[
        Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: ch,
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            color: Colors.grey[400],
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ),
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              if (selectedValue == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
              } else {
                _showOnlyFavorites = false;
              }
            });
          },
          icon: Icon(
            Icons.more_vert,
          color: Colors.grey,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text('My Favorites'),
              value: FilterOptions.Favorites,
            ),
            PopupMenuItem(
              child: Text('All Products'),
              value: FilterOptions.All,
            ),
          ],
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    AppBar appBar = getAppBar(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      drawer: AppDrawer(),
     
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height:18),
                     Text("    Products Available",
                     textAlign: TextAlign.left,
                     
        style: TextStyle(
          fontFamily: "lineto",
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 18
        ),),
        Divider(),
                    // Container(
                    //   margin: EdgeInsets.all(10),
                    //   height: 150,
                    //   width: double.infinity,
                    //   color: Colors.transparent,
                    //   child: Container(
                    //       decoration: BoxDecoration(
                    //         color: const Color(0xffE8FCC6),
                    //         borderRadius: BorderRadius.all(Radius.circular(5)),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.grey,
                    //             blurRadius: 1, // soften the shadow
                    //             spreadRadius: 1, //extend the shadow
                    //             offset: Offset(
                    //               0.5, // Move to right 10  horizontally
                    //               0.5, // Move to bottom 10 Vertically
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: <Widget>[
                    //           Container(
                    //               margin: EdgeInsets.all(5),
                    //               child: Image.asset(
                    //                   'assets/images/optima_logo.png')),
                    //           Container(
                    //             width: 150,
                    //             child: Center(
                    //               child: Text(
                    //                 "All your essentials are right here!",
                    //                 style: TextStyle(
                    //                     color: Colors.black, fontSize: 22),
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )),
                    // ),
                    Expanded(
                      child: ProductsList(_showOnlyFavorites),
                    ),
                  ],
                ),
                DraggableFloatingActionButton(
                  tooltip: "Ask a question!",
                    data: 'Watson',
                    offset: new Offset(10, 10),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: new Icon(
                      Icons.assistant,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Chatbot()));
                    },
                    appContext: context,
                    appBar: appBar),
              ],
            ),
    );
  }
}
