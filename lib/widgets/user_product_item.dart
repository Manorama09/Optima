import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;

  UserProductItem(this.id,this.title);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title,
      style: TextStyle(
color: Colors.black87,
        fontWeight: FontWeight.w500,
      fontSize: 18,
      ),),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id
                  );
              },
              color: Colors.blueGrey,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try{
                Provider.of<Products>(context,listen: false).deleteProduct(id);
                }catch(error){
                  scaffold
                  .showSnackBar(
                    SnackBar(
                      content: Text('Deleting failed!',
                      textAlign: TextAlign.center,
                  ),
                  )
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
