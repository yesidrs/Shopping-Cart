import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/models/products.dart';

part 'cart_events.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvents, CartState> {
  final FirebaseFirestore _firestore;

  StreamSubscription _streamSubs;
  List<Products> _products;

  CartBloc({@required firestore})
      : assert(firestore != null),
        _firestore = firestore,
        super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvents event) async* {
    if (event is GetCartProducts) {
      yield* _mapGetCartToState();
    }
    if (event is AddCartProduct) {
      yield* _mapAddCartToState(event.product);
    }
    if (event is DeleteCartProduct) {
      yield* _mapDeleteCartToState(event.productId);
    }
    if (event is UpdateQuantityProduct) {
      yield* _mapUpdateQuantityToState(event.productId, event.quantity);
    }
    if (event is DeleteAllCartProducts) {
      yield* _mapDeleteAllToState();
    }
  }

  Stream<CartState> _mapGetCartToState() async* {
    _streamSubs =
        _firestore.collection('product_carts').snapshots().listen((onData) {
      _products = onData.docs.map((item) {
        final id = item.reference.id;
        final data = item.data();
        data['id'] = id;
        return Products.fromMap(data);
      }).toList();
    });

    yield CartState(pending: true, productList: _products);
  }

  Stream<CartState> _mapAddCartToState(Products product) async* {
     _firestore
        .collection('product_carts')
        .add(product.toJson())
        .then((value) => print('Cart Product Added'))
        .catchError((err) => print('Failed to add product: $err'));

    yield CartState(pending: true, productList: _products);
  }

  Stream<CartState> _mapDeleteCartToState(String productId) async* {
     _firestore
        .collection('product_carts')
        .doc(productId)
        .delete()
        .then((value) => print('Cart Product Deleted'))
        .catchError((err) => print('Failed to remove product: $err'));

    yield CartState(pending: true, productList: _products);
  }

  Stream<CartState> _mapUpdateQuantityToState(String productId, int quantity) async* {
     _firestore
        .collection('product_carts')
        .doc(productId)
        .update({'quantity': quantity})
        .then((value) => print('Quantity updated'))
        .catchError((err) => print('Failed to update quantity: $err'));

    yield CartState(pending: true, productList: _products);
  }

  Stream<CartState> _mapDeleteAllToState() async* {
    _products.forEach((product) {
       _firestore
          .collection('product_carts')
          .doc(product.id)
          .delete()
          .then((value) => print('Cart Product Deleted'))
          .catchError((err) => print('Failed to remove product: $err'));
    });

    yield CartState(pending: false, productList: _products);
  }

  void cancel() {
    _streamSubs.cancel();
  }
}
