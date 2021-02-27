part of 'cart_bloc.dart';

@immutable
abstract class CartEvents {}

class ProductsAdded extends CartEvents {
  final bool isPending; 
  final List<Products> products;

  ProductsAdded(this.isPending, this.products);
}
