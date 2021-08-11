import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/screens/product_detail_screen/product_detail_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductCardInList extends StatefulWidget {
  const ProductCardInList({Key key, this.product}) : super(key: key);
  final product;
  @override
  _ProductCardInListState createState() => _ProductCardInListState();
}

class _ProductCardInListState extends State<ProductCardInList> {
  String _normalizeNum(num d) {
    d = d.clamp(double.negativeInfinity, 999999);
    d = num.parse(d.toStringAsFixed(6).substring(0, 7));
    if (d == d.toInt()) {
      d = d.toInt();
    }
    return d.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductdetailScreen(
                id: widget.product.sId,
              ),
            ),
          );
        },
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
                child: Column(
              children: [
                (widget.product.isOffer != false)
                    ? Visibility(
                        visible: true,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(left: 200),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                              color: customColorRed,
                            ),
                            child: Center(
                              child: Text(
                                'Save 10 ${LocalKeys.EGP.tr()}',
                                style: AppTheme.heading.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: AppTheme.headingColorBlue,
                            ),
                            spaceH(10),
                            Row(
                              children: [
                                (widget.product.oldPrice != null)
                                    ? Text(
                                        widget.product.oldPrice
                                                .toStringAsFixed(2) +
                                            LocalKeys.EGP.tr(),
                                        style:
                                            AppTheme.headingColorBlue.copyWith(
                                          color: customColorGray,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Container(),
                                spaceW(10),
                                Text(
                                  widget.product.price.toStringAsFixed(2) +
                                      ' ${LocalKeys.EGP.tr()}',
                                  style: AppTheme.subHeadingColorBlue,
                                ),
                              ],
                            ),
                            spaceH(10),
                            (widget.product.reedemablePoints != null)
                                ? Row(
                                    children: [
                                      Image.asset(
                                        'lib/images/product_detail_cutIcon.png',
                                        width: 23,
                                        height: 23,
                                      ),
                                      spaceW(10),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          "${LocalKeys.CART_MESS.tr()} ${widget.product.reedemablePoints.toString()} ${LocalKeys.CART_MESS2.tr()}"
                                              .toString(),
                                          style: AppTheme.subHeading.copyWith(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            spaceH(10),
                            CartData(
                              id: widget.product.sId,
                              name: widget.product.name,
                              price: widget.product.price,
                              oldprice: widget.product.oldPrice,
                              url: widget.product.url,
                              width2: 70.0,
                              width: 150.0,
                              inCart: false,
                            )
                          ],
                        ),
                      ),
                      (widget.product.url != null)
                          ? Expanded(
                              child: Container(
                                height: 80,
                                width: 80,
                                child: customCachedNetworkImage(
                                  context: context,
                                  fit: BoxFit.contain,
                                  url: widget.product.url,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ))));
  }
}
