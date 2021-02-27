import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_cart/bloc/products/products_bloc.dart';
import 'package:shopping_cart/services/cloud_firestore_api.dart';
import 'package:shopping_cart/widgets/product_lists.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    db.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ProductsBloc>(context, listen: true)
        .add(GetProducts(db.products));

    return Scaffold(
      appBar: _customAppBar(),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) {
          return state.isProducts
              ? ProductsList(state.products)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  AppBar _customAppBar() {
    return AppBar(
      title: Text(
        'Tul Foods',
        style: TextStyle(
            color: Colors.black, fontFamily: 'Pacifico', fontSize: 30.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: IconButton(
            icon:
                FaIcon(FontAwesomeIcons.shoppingCart, color: Colors.redAccent),
            onPressed: () => {
              Navigator.pushNamed(context, 'cart')
            },
          ),
        ),
      ],
    );
  }
}
