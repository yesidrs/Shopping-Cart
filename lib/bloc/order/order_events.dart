part of 'order_bloc.dart';

@immutable
abstract class OrderEvents {}

class GetOrderProducts extends OrderEvents {
  final List<Products> products;

  GetOrderProducts(this.products);
}
