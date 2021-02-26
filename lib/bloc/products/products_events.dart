part of 'products_bloc.dart';

@immutable
abstract class ProductsEvents {}

class GetProducts extends ProductsEvents {
  final List<Products> products;

  GetProducts(this.products);
}
