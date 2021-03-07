part of 'order_bloc.dart';

@immutable
abstract class OrderEvents {}

class GetOrderProducts extends OrderEvents {}

class CreateOrderProducts extends OrderEvents {
  final Products product;

  CreateOrderProducts(this.product);
}

class DeleteOrderProducts extends OrderEvents {
  final String productId;

  DeleteOrderProducts(this.productId);
}

class DeleteAllOrderProducts extends OrderEvents  {}
