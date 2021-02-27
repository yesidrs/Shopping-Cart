import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/models/products.dart';

class DB {
  final firestore = FirebaseFirestore.instance;

  List<Products> products;
  List<Products> cartProducts;
  StreamSubscription _streamSubs;

  // Home list products
  void getProducts() async {
    _streamSubs = firestore.collection('products').snapshots().listen((onData) {
      products = onData.docs.map((item) {
        final id = item.reference.id;
        final data = item.data();
        data['id'] = id;
        return Products.fromMap(data);
      }).toList();
    });
  }

  // Cart CRUD
  void getCartProducts() {
    _streamSubs =
        firestore.collection('product_carts').snapshots().listen((onData) {
      cartProducts = onData.docs.map((item) {
        final id = item.reference.id;
        final data = item.data();
        data['id'] = id;
        return Products.fromMap(data);
      }).toList();
    });
  }

  void addCartProducts(Products product) async {
    await firestore
        .collection('product_carts')
        .add(product.toJson())
        .then((value) => print('Cart Product Added'))
        .catchError((err) => print('Failed to add product: $err'));
  }

  void deleteCartProduct(String productId) async {
    await firestore
        .collection('product_carts')
        .doc(productId)
        .delete()
        .then((value) => print('Cart Product Deleted'))
        .catchError((err) => print('Failed to remove product: $err'));
  }

  void cancel() {
    _streamSubs.cancel();
  }
}

final db = new DB();
