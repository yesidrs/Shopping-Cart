import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/models/products.dart';

part 'order_state.dart';
part 'order_events.dart';

class OrderBloc extends Bloc<OrderEvents, OrderState> {
  final FirebaseFirestore _firestore;
  StreamSubscription _streamSubs;
  List<Products> _products;

  OrderBloc({@required firestore})
      : assert(firestore != null),
        _firestore = firestore,
        super(OrderState());

  @override
  Stream<OrderState> mapEventToState(OrderEvents event) async* {
    if (event is GetOrderProducts) {
      yield* _mapGetOrderToState();
    }
    if (event is CreateOrderProducts) {
      yield* _mapAddOrderToState(event.product);
    }
    if (event is DeleteOrderProducts) {
      yield* _mapDeleteOrderToState(event.productId);
    }
    if (event is DeleteAllOrderProducts) {
      yield* _mapDeleteAllToState();
    }
  }

  Stream<OrderState> _mapGetOrderToState() async* {
    _streamSubs = _firestore.collection('order').snapshots().listen((onData) {
      _products = onData.docs.map((item) {
        final id = item.reference.id;
        final data = item.data();
        data['id'] = id;
        return Products.fromMap(data);
      }).toList();
    });

    yield OrderState(productList: _products);
  }

  Stream<OrderState> _mapAddOrderToState(Products product) async* {
       _firestore
          .collection('order')
          .add(product.toJson())
          .then((value) => print('order crated'))
          .catchError((err) => print('Failed to create order: $err'));

    yield OrderState(productList: _products);
  }

  Stream<OrderState> _mapDeleteOrderToState(String productId) async* {
     _firestore
        .collection('order')
        .doc(productId)
        .delete()
        .then((value) => print('Cart Product Deleted'))
        .catchError((err) => print('Failed to remove product: $err'));

    yield OrderState(productList: _products);
  }

  Stream<OrderState> _mapDeleteAllToState() async* {
    _products.forEach((product) {
       _firestore
          .collection('order')
          .doc(product.id)
          .delete()
          .then((value) => print('Cart Product Deleted'))
          .catchError((err) => print('Failed to remove product: $err'));
    });

    yield OrderState(productList: _products);
  }

  void cancel() {
    _streamSubs.cancel();
  }
}
