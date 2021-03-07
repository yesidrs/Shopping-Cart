import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/cart/cart_bloc.dart';
import 'package:shopping_cart/widgets/product_lists.dart';


class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<CartBloc>(context, listen: true)
        .add(GetCartProducts());

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
            return (state.isPending && state.cartProducts.length == 0)
                ? Center(child: Text('Todavia no ha agregado productos'))
                : ProductsCartList(state.cartProducts);
          },
        ));
  }
}
