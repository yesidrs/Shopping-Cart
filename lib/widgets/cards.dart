import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_cart/bloc/cart/cart_bloc.dart';
import 'package:shopping_cart/models/products.dart';

class CustomCard extends StatelessWidget {
  final List<Products> products;
  final int index;

  const CustomCard({this.products, this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: size.height * 0.17,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.3,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    '${products[index].img}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${products[index].name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                    SizedBox(height: 5.0),
                    Text(
                      'sku: ${products[index].sku}',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text('${products[index].description}'),
                  ],
                ),
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.plus, color: Colors.redAccent),
                onPressed: () => {
                  BlocProvider.of<CartBloc>(context)
                      .add(AddCartProduct(products[index]))
                },
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

class CustomCartCard extends StatelessWidget {
  final List<Products> products;
  final int index;

  const CustomCartCard({this.products, this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: size.height * 0.17,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.25,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    '${products[index].img}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${products[index].name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                    SizedBox(height: 5.0),
                    Text(
                      'sku: ${products[index].sku}',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text('${products[index].description}'),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.minus),
                        color: Colors.redAccent,
                        iconSize: 15.0,
                        onPressed: () {
                          if (products[index].quantity <= 1) {
                            BlocProvider.of<CartBloc>(context)
                                .add(DeleteCartProduct(products[index].id));
                          } else {
                            int _quantity = products[index].quantity - 1;
                            BlocProvider.of<CartBloc>(context).add(
                                UpdateQuantityProduct(
                                    products[index].id, _quantity));
                          }
                        },
                      ),
                      Text('${products[index].quantity}'),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.plus),
                        color: Colors.redAccent,
                        iconSize: 15.0,
                        onPressed: () {
                          int _quantity = products[index].quantity + 1;
                          BlocProvider.of<CartBloc>(context).add(
                              UpdateQuantityProduct(
                                  products[index].id, _quantity));
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text('Remover'),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(DeleteCartProduct(products[index].id));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
