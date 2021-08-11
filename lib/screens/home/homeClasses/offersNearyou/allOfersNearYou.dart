import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/domain/pharmacy_product/pharmacy_product_store.dart';
import 'package:konsolto/screens/home/homeClasses/cartItemBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../product_card_in_list.dart';

class AllOfersNearYouPage extends StatelessWidget {
  String id;
  String name;
  String image;
  AllOfersNearYouPage({Key key, this.id, this.name, this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhenRebuilderOr<PharmacyproductStore>(
        initState: (context, rm) =>
            rm.setState((s) => s.getPharmacyproduct(id)),
        observe: () => RM.get<PharmacyproductStore>(),
        builder: (context, model) => AllOfersNearYou(
          title: name,
          image: image,
        ),
        onWaiting: () => Loading(),
        onError: (error) =>
            IN.get<PharmacyproductStore>().getPharmacyproduct(id) == null
                ? Text('$error')
                : AllOfersNearYou(
                    title: name,
                    image: image,
                  ),
      ),
    );
  }
}

class AllOfersNearYou extends StatefulWidget {
  final String title;
  final String image;

  const AllOfersNearYou({Key key, @required this.title, @required this.image})
      : super(key: key);

  @override
  _AllOfersNearYouState createState() => _AllOfersNearYouState();
}

class _AllOfersNearYouState extends State<AllOfersNearYou> {
  final pharmacyProductModel =
      IN.get<PharmacyproductStore>().pharmacyProductModel;

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

  @override
  void initState() {
    _checkIfHasCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            ListView(
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      maxRadius: 50,
                      minRadius: 50,
                      backgroundColor: Colors.white,
                      // backgroundImage: AssetImage(widget.image),
                      child: customCachedNetworkImage(
                        context: context,
                        url: widget.image,
                      ),
                    ),
                    title: Text(
                      "${widget.title} Near you",
                      style: AppTheme.subHeadingColorBlue,
                    ),
                  ),
                  spaceH(20),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: pharmacyProductModel.data.products.length,
                      itemBuilder: (context, index) {
                        return ProductCardInList(
                            product: pharmacyProductModel.data.products[index]);
                      })
                ]),
                      CartBottomBar(cartItems: cartItems, cartTotal: cartTotal)

          ],
        ));
  }
}
