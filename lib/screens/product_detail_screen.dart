import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
   static const routeName = '/product-detail';
  
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column( 
          children: <Widget>[ 
            Container(
        margin:EdgeInsets.all(10),
        width: double.infinity,
        height: 300,
        child: Image.network(loadedProduct.imageUrl,
        fit: BoxFit.cover
        ),
      ),
      SizedBox(height: 10),
     
       Container(
        padding: EdgeInsets.symmetric(horizontal:20),
        width: double.infinity,
        child: Text('₹${loadedProduct.price}',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 44,
          ),        
      textAlign: TextAlign.start,
      softWrap: true,
        ),
       ),
      Container(
        padding: EdgeInsets.symmetric(horizontal:20),
        width: double.infinity,
        child: Text('${loadedProduct.description}',
        style: TextStyle(
          fontSize: 16,
          ), 
      textAlign: TextAlign.start,
      softWrap: true,
      ),
      ),
      ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
  foregroundColor: Colors.white,
  backgroundColor: Theme.of(context).primaryColor,
  child: Icon(Icons.add_shopping_cart),
  onPressed: () { 
    cart.addItem(loadedProduct.id, loadedProduct.price, loadedProduct.title);
   },
),
    );
  }
}
