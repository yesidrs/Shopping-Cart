part of 'cart_bloc.dart';

@immutable
abstract class CartEvents {}

class GetCartProducts extends CartEvents {}

class AddCartProduct extends CartEvents {
  final Products product;

  AddCartProduct(this.product);
}

class DeleteCartProduct extends CartEvents {
  final String productId;

  DeleteCartProduct(this.productId);
}

class UpdateQuantityProduct extends CartEvents {
  final String productId;
  final int quantity;

  UpdateQuantityProduct(this.productId, this.quantity);
}

class DeleteAllCartProducts extends CartEvents {}
