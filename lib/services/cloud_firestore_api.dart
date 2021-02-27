import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/models/products.dart';

class DB {
  final firestore = FirebaseFirestore.instance;

  List<Products> products;
  List<Products> cartProducts;

  // Home list products
  void getProducts() async {
    final snapshot = await firestore.collection('products').get();
    products = snapshot.docs.map((item) => Products.fromMap(item)).toList();
  }

  // Cart CRUD
  void getCartProducts() async {
    final snapshot = await firestore.collection('product_carts').get();
    cartProducts = snapshot.docs.map((item) => Products.fromMap(item)).toList();
  }

  void addCartProducts(Products product) async {
    final products = await firestore
        .collection('product_carts')
        .add(product.toJson())
        .then((value) => print('Product cart added'))
        .catchError((err) => print('Failed to add product: $err'));
  }
}

final db = new DB();
