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
      height: 70.0,
      //margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
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
                        fontFamily: "lineto",
                        fontWeight: FontWeight.w400),
                  ),
                 SizedBox(
                   height: 1,
                 ),
                  Text(
                    '₹' + (product.price).toString(),
                    style: new TextStyle(
                      fontSize: 15.0, 
                      color: Colors.black54,
                      fontFamily: "lineto",
                        fontWeight: FontWeight.w800
                        ),
                  ),
                  
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 10.0, color: Colors.black54,fontFamily: "lineto",
                        ),
                  ),
                ])),
            new Padding(
              padding: new EdgeInsets.only(right: 10.0),
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
                      color: Colors.red[300],
                      onPressed: () {
                        product.toggleFavoriteStatus(
                            authData.token, authData.userId);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
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
                    color: Colors.blueGrey,
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
