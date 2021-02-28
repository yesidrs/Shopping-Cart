import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/models/products.dart';

part 'order_state.dart';
part 'order_events.dart';

class OrderBloc extends Bloc<OrderEvents, OrderState> {
  OrderBloc() : super(OrderState());

  @override
  Stream<OrderState> mapEventToState(OrderEvents event) async* {

    if (event is GetOrderProducts) {
      yield OrderState(productList: event.products);
    }
  }
}
