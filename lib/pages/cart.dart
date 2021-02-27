import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/cart/cart_bloc.dart';
import 'package:shopping_cart/services/cloud_firestore_api.dart';
import 'package:shopping_cart/widgets/product_lists.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    db.getCartProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPending = true;

    BlocProvider.of<CartBloc>(context, listen: true)
        .add(ProductsAdded(isPending, db.cartProducts));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            'Your Cart',
            style: TextStyle(fontFamily: 'Pacifico', fontSize: 27.0),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (_, state) {
            return (state.isPending && !state.isCartProducts)
                ? Center(child: Text('Todavia no ha agregado productos'))
                : (state.isPending && state.isCartProducts)
                    ? ProductsCardList(state.cartProducts)
                    //TODO: Show Order
                    : Center(child: Text('Show Order'));
          },
        ));
  }
}
