import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return Container(
      height: 90.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1, // soften the shadow
              spreadRadius: 1, //extend the shadow
              offset: Offset(
                0.5, // Move to right 10  horizontally
                0.5, // Move to bottom 10 Vertically
              ),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'Price: ₹' + (product.price).toString(),
                    style: new TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 10.0, color: Colors.black),
                  ),
                ])),
            new Padding(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Consumer<Product>(
                    builder: (ctx, product, _) => IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 30,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        product.toggleFavoriteStatus(
                            authData.token, authData.userId);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                    onPressed: () {
                      cart.addItem(product.id, product.price, product.title);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to cart!'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                cart.removeSingleItem(product.id);
                              }),
                        ),
                      );
                    },
                    color: Colors.lightGreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: Container(
    //     child: ListTile(
    //         onTap: () {
    //           Navigator.of(context).pushNamed(
    //             ProductDetailScreen.routeName,
    //             arguments: product.id,
    //           );
    //         },

    //         leading:
    //         Consumer<Product>(
    //           builder: (ctx, product, _) => IconButton(
    //             icon: Icon(
    //               product.isFavorite ? Icons.favorite : Icons.favorite_border,
    //             ),
    //             color: Colors.red,
    //             onPressed: () {
    //               product.toggleFavoriteStatus(
    //                 authData.token,
    //                 authData.userId
    //                 );
    //             },
    //           ),
    //         ),

    //         title: Text(
    //           product.title,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontSize: 14),
    //         ),

    //         subtitle: Text(
    //           product.description
    //         ),

    //         trailing:
    //           IconButton(
    //           icon: Icon(
    //             Icons.shopping_cart,
    //           ),
    //           onPressed: () {
    //             cart.addItem(product.id, product.price, product.title);
    //             Scaffold.of(context).hideCurrentSnackBar();
    //             Scaffold.of(context).showSnackBar(
    //               SnackBar(
    //                 content: Text('Added to cart!'),
    //                 duration: Duration(seconds: 2),
    //                 action: SnackBarAction(
    //                     label: 'UNDO',
    //                     onPressed: () {
    //                       cart.removeSingleItem(product.id);
    //                     }),
    //               ),
    //             );
    //           },
    //           color: Colors.lightGreen,
    //         ),
    //         ),
    //   ),
    //   );
  }
}
