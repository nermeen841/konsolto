import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';

import 'package:konsolto/domain/brand_product/brand_product_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:konsolto/screens/home/homeClasses/cartItemBar.dart';

import '../../product_card_in_list.dart';

class AllbrandProductsPage extends StatelessWidget {
  String id;
  String name;
  AllbrandProductsPage({Key key, this.id, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(id);
    print(name);
    return Scaffold(
      body: WhenRebuilderOr<BrandsProductsStore>(
        initState: (context, rm) => rm.setState((s) => s.getProductsbrand(id)),
        observe: () => RM.get<BrandsProductsStore>(),
        builder: (context, model) => AllbrandProducts(
          title: name,
        ),
        onWaiting: () => Loading(),
        onError: (error) =>
            IN.get<BrandsProductsStore>().getProductsbrand(id) == null
                ? Text('$error')
                : AllbrandProducts(
                    title: name,
                  ),
      ),
    );
  }
}

class AllbrandProducts extends StatefulWidget {
  final String title;
  const AllbrandProducts({Key key, @required this.title}) : super(key: key);

  @override
  _AllbrandProductsState createState() => _AllbrandProductsState();
}

class _AllbrandProductsState extends State<AllbrandProducts> {
  final brandsProductModel = IN.get<BrandsProductsStore>().brandsProductModel;
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  bool hasCart = false;
  String cartTotal;
  String cartItems;

  _checkIfHasCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('hasCart') != null) {
      setState(() {
        hasCart = pref.getBool('hasCart');
      });
    }
    if (pref.getString('cartTotal') != null) {
      setState(() {
        cartTotal = pref.getString('cartTotal');
      });
    }
    if (pref.getString('cartItems') != null) {
      setState(() {
        cartItems = pref.getString('cartItems');
      });
    }
  }

  _get_qty() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final qty = pref.getString('quantity');
    return qty;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._checkIfHasCart();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(children: [
          ListView(
            shrinkWrap: true,
            primary: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: brandsProductModel.data.products.length,
                itemBuilder: (context, index) {
                  return ProductCardInList(
                      product: brandsProductModel.data.products[index]);
                },
              ),
            ],
          ),
          CartBottomBar(cartItems: cartItems, cartTotal: cartTotal)
        ]));
  }
}
