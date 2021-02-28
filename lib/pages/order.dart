import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: Center(
        child: Text('OrderPage'),
      ),
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
