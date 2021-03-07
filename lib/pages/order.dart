import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/order/order_bloc.dart';
import 'package:shopping_cart/models/products.dart';



class OrderPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    BlocProvider.of<OrderBloc>(context, listen: true)
        .add(GetOrderProducts());

    return Scaffold(
      appBar: _customAppBar(),
      body: BlocBuilder<OrderBloc, OrderState> (
        builder: ( _ , state) {
          return state.isProducts
              ? OrderProductsList(products: state.products,)
              : Center(child: CircularProgressIndicator());
        },
      )
    );
  }

  AppBar _customAppBar() {
    return AppBar(
      title: Text(
        'Tu Orden',
        style: TextStyle(
            color: Colors.white, fontFamily: 'Pacifico', fontSize: 30.0),
      ),
      backgroundColor: Colors.redAccent,
    );
  }
}


class OrderProductsList extends StatelessWidget {
  final List<Products> products;

  const OrderProductsList({this.products}); 

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (_, index) => ListTile(
          leading: Container(
              width: 90.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                '${products[index].img}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text('${products[index].name}'),
          subtitle: Text('Cantidad ${products[index].quantity}'),
        ),
      ),
    );
  }
}
