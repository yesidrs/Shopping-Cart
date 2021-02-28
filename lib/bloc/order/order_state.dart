part of 'order_bloc.dart';

class OrderState {
  final bool isProducts;
  final List<Products> products;

  OrderState({List<Products> productList})
      : products = productList ?? null,
        isProducts = (productList != null) ? true : false;
}
