import 'package:provider/provider.dart';
import '../providers/cart.dart';

import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  CartItem(this.id, this.price, this.quantity, this.title, this.productId);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,

            builder: (ctx) => AlertDialog(
                  title: Text('Confirmation',style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),),
                  content: Text(
                      'Do you want to delete the selected item from the cart?',
                      style: TextStyle(
                        color: Colors.black87
                      ),
                      ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Go back',style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),)),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Confirm',style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),))
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(1),
          child: ListTile(
            leading: CircleAvatar(
              radius: 23,
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('₹$price',style: TextStyle(
                        color: Colors.white
                      ),),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Cost: ₹${price * quantity}',

            style: TextStyle(
                        color: Colors.black54
                      ),),
            trailing: Text('$quantity',
            style:TextStyle(
                        color: Theme.of(context).primaryColor
                      ) ,
            ),
          ),
        ),
      ),
    );
  }
}
