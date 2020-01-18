import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_max_flutter/providers/product.dart';
import 'package:shop_app_max_flutter/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/editProductScreen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null,
      title: " ",
      description: " ",
      imageUrl: " ",
      price: 0);
  bool _isInt=true;

  var _initValue ={ "title" : '' , "description" : '' , "price" : '' , "imageUrl" : '' ,   };
  @override
  void initState()
  {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies()
  {
    if(_isInt)
    {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId!=null)
      {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(productId);

        _initValue =
        {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
//          "imageUrl": _editedProduct.imageUrl,
          "imageUrl": '',
        };
        _imageUrlController.text =_editedProduct.imageUrl;
      }
    }
    _isInt=false;
    super.didChangeDependencies();
  }

  @override
  void dispose()
  {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl()
  {
    if (!_imageUrlFocusNode.hasFocus)
    {
      if (
          (
              !_imageUrlController.text.startsWith('http')
                &&
              !_imageUrlController.text.startsWith('https')
          )
            ||
          (
              !_imageUrlController.text.endsWith('.png')
                  &&
              !_imageUrlController.text.endsWith('.jpg')
                  &&
              !_imageUrlController.text.endsWith('.jpeg')
          )
      )
        {
          return ;
        }
        setState(() {});
    }
  }

  void _saveForm()
  {
    var isValid = _form.currentState.validate();

    if (!isValid)
    {
      return null;
    }
    _form.currentState.save();
    Provider.of<ProductsProvider>(context , listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar
      (
          title: Text('Edit Product'),
          actions: <Widget>
          [
            IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                onSaved: (value) =>
                _editedProduct = Product(
                    id: null,
                    title: value,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price),
                validator: (value)
                {
                  if (value.isEmpty) {
                    return 'Please Provide a Value';
                  }
                  return null;
                },
                initialValue: _initValue["title"],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                onSaved: (value) =>
                _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: double.parse(value)),
                validator: (value)
                {
                  if (value.isEmpty) {
                    return 'Please enter a Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'please enter a number greater than zero "0" ';
                  }
                  return null;
                },
                initialValue: _initValue["price"] ,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) =>
                _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: value,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price),
                validator: (value)
                {
                  if (value.isEmpty) {
                    return ' please enter a description';
                  }
                  if (value.length < 10)
                  {
                    return 'Should be at least 10 character long .';
                  }
                  return null;
                },
                initialValue: _initValue["description"] ,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text("Enter a Url")
                        : FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image Url"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _saveForm(),
                      onSaved: (value) =>
                      _editedProduct = Product(
                          id: null,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          imageUrl: value,
                          price: _editedProduct.price),
                      validator: (value)
                      {
                        if (value.isEmpty)
                          {
                          return 'Please enter an image URL. ';
                        }
                        if(!value.startsWith('http') && !value.startsWith('https') )
                          {
                            return 'Please enter a valid URL.';
                          }
                        if(!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg'))
                          {
                            return 'Please enter a valid URL.';
                          }
                        return null;
                      },

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
