import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/models/products.dart';

part 'products_state.dart';
part 'products_events.dart';

class ProductsBloc extends Bloc<ProductsEvents, ProductsState> {
  ProductsBloc() : super(ProductsState());

  @override
  Stream<ProductsState> mapEventToState(ProductsEvents event) async* {

    if (event is GetProducts) {
      yield ProductsState(product: event.products);
    }
  }
}
