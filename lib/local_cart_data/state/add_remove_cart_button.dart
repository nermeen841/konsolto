import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/data/user_cart/Post_user_cart_model/add_product_tocart.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/models/cartModels.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class CartData extends StatefulWidget {
  String id;
  String name;
  String url;
  var price;
  var oldprice;
  double width;
  double width2;
  bool inCart = false;
  CartData(
      {Key key,
      this.id,
      this.name,
      this.url,
      this.price,
      this.oldprice,
      @required this.width,
      @required this.width2,
      this.inCart})
      : super(key: key);

  @override
  _CartDataState createState() => _CartDataState();
}

class _CartDataState extends State<CartData> {
  int counter = 1;
  bool hasCart = false;
  bool _visible = true;
  bool _visible2 = false;

  _checkIfProductInCart() async {
    Provider.of<CartDataProvider>(context, listen: false)
        .checkIfProductInCart(widget.id)
        .then((value) {
      if (value == null) {
        return;
      } else if (value > 0) {
        setState(() {
          this._visible = false;
          this._visible2 = true;
          widget.inCart = true;
          this.counter = value;
        });
        return;
      }
    });
  }

  _addProductToCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Provider.of<CartDataProvider>(context, listen: false)
        .addProductToCart(widget.id)
        .then((value) {
      print('Vale:$value');
      if (value == null) {
        // setState(() {
        //   preferences.setBool('hasCart', true);
        //   hasCart = preferences.getBool('hasCart');
        //   this._visible = false;
        //   this._visible2 = true;
        //   widget.inCart = true;
        //   this.counter = 0;
        // });
        return;
      } else if (value > 0) {
        setState(() {
          preferences.setBool('hasCart', true);
          hasCart = preferences.getBool('hasCart');
          this._visible = false;
          this._visible2 = true;
          widget.inCart = true;
          this.counter = value;
        });
        return;
      }
    });
  }

  _removeProductFromCart() async {
    Provider.of<CartDataProvider>(context, listen: false)
        .removeProductFromCart(widget.id)
        .then((value) {
      if (value == null) {
        print('Value  Null');
        setState(() {
          this._visible = true;
          this._visible2 = false;
          widget.inCart = false;
          this.counter = 0;
        });
        Provider.of<CartDataProvider>(context, listen: false)
            .dencrement(price: double.parse(widget.price.toString()));
        Provider.of<CartProductProvider>(context, listen: false)
            .updateCartRemoveProduct();
        Provider.of<CartProductProvider>(context, listen: false)
            .updateCartRemoveProduct();
        return;
      } else if (value > 0) {
        print('Value  >= 0');

        setState(() {
          this._visible = false;
          this._visible2 = true;
          this.counter = value;
          widget.inCart = true;
        });
        return;
      } else if (value == 0) {
        print('Value  == 0');
        setState(() {
          this._visible = true;
          this._visible2 = false;
          widget.inCart = false;
          this.counter = 0;
        });
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    this._checkIfProductInCart();
    return Container(
      child: addToCartButton(context, widget.id, widget.name, widget.url,
          widget.price, widget.oldprice),
    );
  }

  addToCartButton(
      BuildContext context, productId, productName, price, oldPrice, imageUrl) {
    return (widget.inCart) ? cartItemincreaseDeacrease() : cartItem1();
  }

  cartItemincreaseDeacrease() {
    return Container(
      width: widget.width,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: (apiLang() == 'en')
                  ? BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
              border: Border.all(color: customColor2),
              color: Colors.white,
            ),
            child: Center(
              child: InkWell(
                child: Icon(
                  Icons.remove,
                  size: 20,
                  color: Colors.grey,
                ),
                onTap: () async {
                  this._removeProductFromCart();
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString('quantity', counter.toString());
                },
              ),
            ),
          ),
          Container(
              width: widget.width2,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: customColor),
                color: Colors.white,
              ),
              child: Center(
                child: Text(counter.toString()),
              )),
          Container(
              width: 30,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: customColor),
                color: Colors.white,
                borderRadius: (apiLang() == 'en')
                    ? BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
              ),
              child: Center(
                child: InkWell(
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: customColor,
                  ),
                  onTap: () async {
                    this._addProductToCart();
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString('quantity', counter.toString());
                  },
                ),
              )),
        ],
      ),
    );
  }

  cartItem1() {
    return Column(children: [
      Visibility(
          visible: _visible,
          child: InkWell(
            onTap: () async {
              this._addProductToCart();
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('quantity', counter.toString());
            },
            child: Container(
              width: widget.width,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: customColorGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.cartPlus,
                    color: Colors.white,
                    size: 15,
                  ),
                  spaceW(10),
                  Text(
                    LocalKeys.ADD_TO_CART.tr(),
                    style: AppTheme.heading.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )),
      Visibility(
          visible: _visible2,
          child: Container(
            width: widget.width,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: customColor2),
                      color: Colors.white,
                      borderRadius: (apiLang() == 'en')
                          ? BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            )),
                  child: Center(
                    child: InkWell(
                      child: Icon(
                        Icons.remove,
                        size: 15,
                        color: customColorGray,
                      ),
                      onTap: () async {
                        this._removeProductFromCart();
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString('quantity', counter.toString());
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Container(
                    width: widget.width2,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: customColor),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(counter.toString()),
                    )),
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: (apiLang() == 'en')
                          ? BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            )
                          : BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                      border: Border.all(color: customColor2),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: InkWell(
                        child: Icon(
                          Icons.add,
                          size: 15,
                        ),
                        onTap: () async {
                          this._addProductToCart();
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString('quantity', counter.toString());
                        },
                      ),
                    )),
              ],
            ),
          ))
    ]);
  }

  bool isExistingInCart(List<Cart> state, Cart cartItem) {
    bool found = false;
    state.forEach((element) {
      if (element.sId == cartItem.sId) {
        found = true;
      }
    });
    return found;
  }
}
