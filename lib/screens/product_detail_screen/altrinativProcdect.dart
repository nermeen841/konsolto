import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/screens/product_detail_screen/product_detail_screen.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class AlternativeProductdetailScreen extends StatefulWidget {
  List alternative;
  AlternativeProductdetailScreen({Key key, @required this.alternative})
      : super(key: key);
  @override
  _AlternativeProductdetailScreenState createState() =>
      _AlternativeProductdetailScreenState();
}

class _AlternativeProductdetailScreenState
    extends State<AlternativeProductdetailScreen> {
  @override
  Widget build(BuildContext context) {
    return (widget.alternative.isEmpty)
        ? Container()
        : Container(
            child: Column(
              children: [
                Text(LocalKeys.ALTERNATIVE_MESS.tr(),
                    style: AppTheme.heading.copyWith(color: customColor)),
                spaceH(10),
                Container(
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.alternative.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProductdetailScreen(
                                id: widget.alternative[index]['_id'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (widget.alternative[index]['isOffer'] == true)
                                    ? Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: customColorRed,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Save 10 ' + LocalKeys.EGP.tr(),
                                            style: AppTheme.heading.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                spaceH(10),
                                Center(
                                  child: Container(
                                    height: 80,
                                    width: 50,
                                    child: customCachedNetworkImage(
                                      context: context,
                                      fit: BoxFit.contain,
                                      url: widget.alternative[index]['url'],
                                    ),
                                  ),
                                ),
                                spaceH(10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .65,
                                        child: (apiLang() == 'en')
                                            ? Text(
                                                (widget
                                                            .alternative[index]
                                                                ['nameArabic']
                                                            .length >
                                                        20)
                                                    ? widget.alternative[index][
                                                                    'nameArabic']
                                                                .substring(
                                                                    0, 20) +
                                                            "...." ??
                                                        ""
                                                    : widget.alternative[index]
                                                            ['nameArabic'] ??
                                                        "",
                                                style:
                                                    AppTheme.headingColorBlue,
                                              )
                                            : Text(
                                                (widget
                                                            .alternative[index]
                                                                ['name']
                                                            .length >
                                                        20)
                                                    ? widget.alternative[index]
                                                                    ['name']
                                                                .substring(
                                                                    0, 20) +
                                                            "...." ??
                                                        ""
                                                    : widget.alternative[index]
                                                            ['name'] ??
                                                        "",
                                                style:
                                                    AppTheme.headingColorBlue,
                                              ),
                                      ),
                                      spaceW(10),
                                      Text(
                                        widget.alternative[index]['price']
                                                .toString() +
                                            LocalKeys.EGP.tr(),
                                        style: AppTheme.heading,
                                      ),
                                    ],
                                  ),
                                ),
                                spaceH(15),
                                Center(
                                  child: CartData(
                                    id: widget.alternative[index]['_id'],
                                    name: widget.alternative[index]['name'],
                                    price: widget.alternative[index]['price'],
                                    url: widget.alternative[index]['url'],
                                    oldprice: widget.alternative[index]
                                        ['monthlyPrice'],
                                    width: 150.0,
                                    width2: 70.0,
                                    inCart: false,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
