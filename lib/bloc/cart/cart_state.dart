part of 'cart_bloc.dart';

class CartState {
  final bool isPending;
  final bool isCartProducts;
  final List<Products> cartProducts;

  CartState({ 
    bool pending = true,
    List<Products> productList,
  })  : isPending = pending,
        cartProducts = (productList == null) ? [] : productList,
        isCartProducts = (productList != null) ? true : false;
}
