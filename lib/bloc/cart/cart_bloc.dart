import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/models/products.dart';

part 'cart_events.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvents, CartState> {
  CartBloc() : super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvents event) async* {

    if (event is ProductsAdded) {
      yield CartState(pending: event.isPending, productList: event.products);
    }
  }
}
