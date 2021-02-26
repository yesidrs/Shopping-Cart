part of 'products_bloc.dart';

class ProductsState {
  final bool isProducts;
  final List<Products> products;

  ProductsState({List<Products> product})
      : products = product ?? null,
        isProducts = (product != null) ? true : false;
}
