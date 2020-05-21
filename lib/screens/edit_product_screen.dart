import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import './visual_recognition_screen.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.grey),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading

          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    Text('Manage',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontSize: 70,
                  fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 5,),
                Text('Product Details',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontSize: 38,
                  fontWeight: FontWeight.w600
                ),),
                SizedBox(
                  height: 30,
                ),
                Text('Enter your product details below:',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "lineto",
                fontSize: 17,
                fontWeight: FontWeight.w400
              ),),
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: value,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            price: double.parse(value),
                            description: _editedProduct.description,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: value,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    SizedBox(height: 15),
                 new Center(
                  child: Text('OR',
                  style: TextStyle(color: Colors.grey,
                  fontSize: 20,
                  ),
                  )
                ),
                SizedBox(height: 15),
                     Text('You can also upload a photo instead!',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "lineto",
                fontSize: 17,
                fontWeight: FontWeight.w400
              ),),
              SizedBox(
                        height:MediaQuery.of(context).size.height/100
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ScreenVisualRecognition()));
                        },
                        child: Text('Upload a Photo',
                        style: TextStyle(
                  color: Colors.white,
                  fontFamily: "lineto",
                  fontSize: 23,
                  fontWeight: FontWeight.w600
              ),),
                      ),
                    ),


                  ],
                ),
              ),
            ),
    );
  }
}
