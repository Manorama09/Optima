import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', 
      style: TextStyle(
      color: Colors.black87,
      fontFamily: "lineto",
      fontWeight: FontWeight.w300
      ),),
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                SizedBox(
                  height:10
                ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: Text(
                      'Total:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal:15.0),
                 child: Text(
                        '₹${cart.totalAmount.toStringAsFixed(2)}',
                        
                  style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontSize: 70,
                  fontWeight: FontWeight.w600
              ),
                      ),
),
                 OrderButton(cart: cart),
                 SizedBox(
                  height:10
                ),               
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.keys.toList()[i],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        child: _isLoading
        ?CircularProgressIndicator() 
        :Text('PLACE ORDER',
         style: TextStyle(
                  color: Colors.white,
                  fontFamily: "lineto",
                  fontSize: 23,
                  fontWeight: FontWeight.w600
              ),
        ),
        onPressed: (widget.cart.totalAmount<=0 || _isLoading ==true)
        ?null 
        : () async {
          setState(() {
            _isLoading=true;
          });
          await Provider.of<Orders>(context, listen: false).addOrder(
            widget.cart.items.values.toList(),
            widget.cart.totalAmount,
          );
          setState(() {
            _isLoading =false;
          });
          widget.cart.clear();
        },
        textColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
