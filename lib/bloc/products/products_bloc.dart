import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/models/products.dart';

part 'products_state.dart';
part 'products_events.dart';

class ProductsBloc extends Bloc<ProductsEvents, ProductsState> {
  final FirebaseFirestore _firestore;

  StreamSubscription _streamSubs;
  List<Products> _products;

  ProductsBloc({@required firestore})
      : assert(firestore != null),
        _firestore = firestore,
        super(ProductsState());

  @override
  Stream<ProductsState> mapEventToState(ProductsEvents event) async* {
    if (event is GetProducts) {
      yield* _mapGetProductsToState();
    }
  }

  Stream<ProductsState> _mapGetProductsToState() async* {
    _streamSubs =
        _firestore.collection('products').snapshots().listen((onData) {
      _products = onData.docs.map((item) {
        final id = item.reference.id;
        final data = item.data();
        data['id'] = id;
        return Products.fromMap(data);
      }).toList();
    });

    yield ProductsState(productList: _products);
  }

  void cancel() {
    _streamSubs.cancel();
  }
}
