import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/home.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder> {
    'home' : (BuildContext context) => HomePage(),
  };
}
