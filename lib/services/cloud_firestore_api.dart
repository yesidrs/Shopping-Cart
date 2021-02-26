import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/models/products.dart';

class DB {
  final firestore = FirebaseFirestore.instance;

  List<Products> products;

  void getProducts() async {
    final snapshot = await firestore.collection('products').get();
    products = snapshot.docs.map((item) => Products.fromMap(item)).toList();
  }
}
