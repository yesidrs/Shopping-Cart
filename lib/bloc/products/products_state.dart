part of 'products_bloc.dart';

class ProductsState {
  final bool isProducts;
  final List<Products> products;

  ProductsState({List<Products> productList})
      : products = productList ?? null,
        isProducts = (productList != null) ? true : false;
}
