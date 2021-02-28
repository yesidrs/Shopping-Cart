import 'package:flutter/material.dart';
import 'package:shopping_cart/models/products.dart';
import 'package:shopping_cart/widgets/cards.dart';
import 'package:shopping_cart/services/cloud_firestore_api.dart';

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

class ProductsCartList extends StatefulWidget {
  final List<Products> products;

  const ProductsCartList(this.products);

  @override
  _ProductsCartListState createState() => _ProductsCartListState();
}

class _ProductsCartListState extends State<ProductsCartList> {

  @override
    void initState() {
      db.getOrderProducts();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: widget.products.length,
            itemBuilder: (_, index) =>
                CustomCartCard(products: widget.products, index: index),
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
              RaisedButton(
                child:
                    Text('Crear Orden', style: TextStyle(color: Colors.white)),
                color: Colors.redAccent,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                onPressed: () {
                  final cartProducts = db.cartProducts;
                  final orderProducts = db.orderProducts;
                  
                  orderProducts.forEach((product) => {db.deleteOrderProducts(product.id)});
                  cartProducts.forEach((product) => {db.createOrder(product)});
                  cartProducts.forEach((product) => {db.deleteCartProduct(product.id)});
                  Navigator.popAndPushNamed(context, 'order');
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
