import 'package:meta/meta.dart';

class Products {
  final String description;
  final String img;
  final String name;
  final String sku;

  Products({
    @required this.description,
    @required this.img,
    @required this.name,
    @required this.sku,
  });


  factory Products.fromMap(dynamic data) => Products(
      description: data['description'],
      img: data['img'],
      name: data['name'],
      sku: data['sku'],
  );

  Map<String, dynamic> toJson() => {
    'description': description,
    'img': img,
    'name': name,
    'sku': sku,
  };

}
