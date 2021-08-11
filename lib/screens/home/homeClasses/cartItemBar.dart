import 'package:flutter/material.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/models/cartModels.dart';
import 'package:konsolto/screens/order_cart_tracking/mycart.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:easy_localization/easy_localization.dart';

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({
    Key key,
    @required this.cartItems,
    @required this.cartTotal,
  }) : super(key: key);

  final String cartItems;
  final String cartTotal;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CartDataProvider>(context).totalQuantity == 0) {
      Provider.of<CartDataProvider>(context, listen: false).setData();
    }
    return (Provider.of<CartDataProvider>(context).totalQuantity == 0)
        ? Container()
        : Positioned(
            left: 10,
            right: 10,
            bottom: 30,
            child: InkWell(
              onTap: () {
                RM.navigate.to(MycartPage());
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF18de12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          Provider.of<CartDataProvider>(context)
                                  .totalQuantity
                                  .toString() +
                              " " +
                              LocalKeys.ITEMS_ADDED_TO_CART.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          )),
                      Text(
                        Provider.of<CartDataProvider>(context)
                                .totalPrice
                                .toStringAsFixed(2) +
                            ' ${LocalKeys.EGP.tr()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ]),
              ),
            ),
          );
  }
}
