import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/cloud_firestore_api.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: _productsList(context),
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
              //TODO: add cartlist
            },
          ),
        ),
      ],
    );
  }

  Widget _productsList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _card(context),
          _card(context),
          _card(context),
        ],
      ),
    );
  }

  Widget _card(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: size.height * 0.17,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.3,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    'https://www.revistalabarra.com/wp-content/uploads/2019/04/burguer-master-2019-1500x800.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hamburguesa Doble',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                    SizedBox(height: 5.0),
                    Text(
                      'sku: 2004',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text('Hamburguesa doble con triple queso'),
                  ],
                ),
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.plus, color: Colors.redAccent),
                onPressed: () => {
                  //TODO: Add Product to Cart
                },
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
