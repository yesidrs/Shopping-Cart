import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_cart/models/products.dart';
import 'package:shopping_cart/services/cloud_firestore_api.dart';

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
                  //TODO: Add Product to Cart
                  db.addCartProducts(products[index])
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
              //TODO: Add CRUD buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.minus),
                    color: Colors.redAccent,
                    iconSize: 15.0,
                    onPressed: () {},
                  ),
                  Text('1'),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.plus),
                    color: Colors.redAccent,
                    iconSize: 15.0,
                    onPressed: () {},
                  ),
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
