import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/cart/cart_bloc.dart';
import 'package:shopping_cart/bloc/order/order_bloc.dart';
import 'package:shopping_cart/models/products.dart';
import 'package:shopping_cart/widgets/cards.dart';

class ProductsList extends StatelessWidget {
  final List<Products> products;

  const ProductsList(this.products);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (_, index) => CustomCard(products: products, index: index),
      ),
    );
  }
}

class ProductsCartList extends StatelessWidget {
  final List<Products> products;

  const ProductsCartList(this.products);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (_, index) =>
                CustomCartCard(products: products, index: index),
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child:
                    Text('Crear Orden', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.all(16.0)
                ),
                onPressed: () {
                  BlocProvider.of<OrderBloc>(context)
                      .add(DeleteAllOrderProducts());

                  products.forEach((product) {
                    BlocProvider.of<OrderBloc>(context)
                        .add(CreateOrderProducts(product));
                  });

                  Navigator.popAndPushNamed(context, 'order');

                  BlocProvider.of<CartBloc>(context)
                      .add(DeleteAllCartProducts());
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
