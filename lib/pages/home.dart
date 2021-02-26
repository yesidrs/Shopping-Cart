import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_cart/bloc/products/products_bloc.dart';
import 'package:shopping_cart/models/products.dart';
import 'package:shopping_cart/services/firestore_instance_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = new DB();

  @override
  void initState() {
    db.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Products> newProduct = [
      Products(
        description: 'Hamburguesa doble con triple queso',
        img:
            'https://www.revistalabarra.com/wp-content/uploads/2019/04/burguer-master-2019-1500x800.jpg',
        name: 'Hamburguesa doble',
        sku: '12344',
      ),
      Products(
        description: 'Hamburguesa doble con triple Tocineta',
        img:
            'https://www.revistalabarra.com/wp-content/uploads/2019/04/burguer-master-2019-1500x800.jpg',
        name: 'Hamburguesa Tocineton',
        sku: '200',
      ),
      Products(
        description: 'Hamburguesa con carne vegetariana',
        img:
            'https://www.revistalabarra.com/wp-content/uploads/2019/04/burguer-master-2019-1500x800.jpg',
        name: 'Hamburguesa Vegetariana',
        sku: '300',
      ),
    ];

    BlocProvider.of<ProductsBloc>(context).add(GetProducts(newProduct));

    return Scaffold(
      appBar: _customAppBar(),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) {
          return state.isProducts
              ? ProductsList(state.products)
              : Center(child: CircularProgressIndicator());
          //: Center(child: Text('No Hay Productos'));
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
              //TODO: add cartlist
            },
          ),
        ),
      ],
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<Products> products;

  const ProductsList(this.products);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (_, index) => _card(context, index),
      ),
    );
  }

  Widget _card(BuildContext context, int index) {
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
                    '${products[index].img}',
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
                    Text('${products[index].name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                    SizedBox(height: 5.0),
                    Text(
                      '${products[index].sku}',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text('${products[index].description}'),
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
