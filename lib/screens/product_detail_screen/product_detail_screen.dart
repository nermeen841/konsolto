import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/screens/home/homeClasses/cartItemBar.dart';
import 'package:konsolto/screens/product_detail_screen/altrinativProcdect.dart';
import 'package:konsolto/screens/product_detail_screen/productdetailApi.dart';
import 'package:share/share.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class ProductdetailScreen extends StatefulWidget {
  String id;
  ProductdetailScreen({Key key, @required this.id}) : super(key: key);
  @override
  _ProductdetailScreenState createState() => _ProductdetailScreenState();
}

class _ProductdetailScreenState extends State<ProductdetailScreen> {
  String cartTotal;
  String cartItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocalKeys.PRODUCT_DETAIL.tr()),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            FutureBuilder(
                future: DetailproductApi.productdatail(widget.id),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      primary: true,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      children: [
                        Stack(
                          children: [
                            Container(
                                // height: 250,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: customCachedNetworkImage(
                                      context: context,
                                      fit: BoxFit.contain,
                                      url: snapshot.data['url'],
                                    ),
                                  ),
                                )),
                            Align(
                              alignment: (apiLang() == 'en')
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: InkWell(
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    onTap: () async {
                                      await Share.share(
                                        "Hey Check ${snapshot.data['name']} on Konsolto\n" +
                                            snapshot.data['dynamicLink'],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        spaceH(10),
                        (snapshot.data['isLimited'] == true)
                            ? Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          // width: 120,
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
                                              LocalKeys.LIMITTED.tr(),
                                              style: AppTheme.heading.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (apiLang() == 'en')
                                                      ? snapshot
                                                          .data['nameArabic']
                                                      : snapshot.data['name'] ??
                                                          "",
                                                  style:
                                                      AppTheme.headingColorBlue,
                                                ),
                                                Text(
                                                  snapshot.data['slug'] ?? "",
                                                  style: AppTheme.subHeading,
                                                ),
                                                spaceH(10),
                                                Text(
                                                  snapshot.data['price']
                                                              .toString() +
                                                          LocalKeys.EGP.tr() ??
                                                      "",
                                                  style: AppTheme
                                                      .subHeadingColorBlue,
                                                ),
                                                spaceH(10),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.syncAlt,
                                                      color:
                                                          HexColor("#FC0404"),
                                                      size: 15,
                                                    ),
                                                    spaceW(10),
                                                    SizedBox(
                                                      width: 270,
                                                      child: Text(
                                                        LocalKeys
                                                            .ALTERNATIVE_PRODUCT
                                                            .tr(),
                                                        style: AppTheme
                                                            .subHeading
                                                            .copyWith(
                                                          color: HexColor(
                                                              "#FC0404"),
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                spaceH(10),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 340,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: HexColor(
                                                              "#00659A")),
                                                      color: Colors.blue[200],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          LocalKeys.NOTIFY_ME
                                                              .tr(),
                                                          style: AppTheme
                                                              .heading
                                                              .copyWith(
                                                            color: customColor,
                                                          ),
                                                        ),
                                                        spaceW(10),
                                                        Icon(
                                                            FontAwesomeIcons
                                                                .bell,
                                                            color: customColor)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        spaceH(10),
                        Card(
                          //  elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            child: Column(
                              children: [
                                (snapshot.data['isOffer'] == true)
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          // width: 120,
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
                                              'Save 10 ' + LocalKeys.EGP.tr(),
                                              style: AppTheme.heading.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .87,
                                            child: Text(
                                                (apiLang() == 'en')
                                                    ? snapshot
                                                        .data['nameArabic']
                                                    : snapshot.data['name'] ??
                                                        "",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: customColor,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ),
                                          spaceH(7),
                                          Text(
                                            snapshot.data['formQuantity'] ?? "",
                                            style: AppTheme.subHeading,
                                          ),
                                          spaceH(7),
                                          (snapshot.data['price'].toString() ==
                                                  null)
                                              ? Container()
                                              : Text(
                                                  snapshot.data['price']
                                                          .toStringAsFixed(2) +
                                                      LocalKeys.EGP.tr(),
                                                  style: AppTheme
                                                      .subHeadingColorBlue
                                                      .copyWith(fontSize: 16),
                                                ),
                                          spaceH(7),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'lib/images/motorCycleIcon.png',
                                                width: 25,
                                                height: 25,
                                              ),
                                              spaceW(5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: Text(
                                                  snapshot.data[
                                                          'deliveryNote'] ??
                                                      "",
                                                  style: AppTheme.subHeading
                                                      .copyWith(
                                                          color: HexColor(
                                                              '#d0011a'),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'lib/images/product_detail_cutIcon.png',
                                                width: 23,
                                                height: 23,
                                              ),
                                              spaceW(5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.67,
                                                child: Text(
                                                  "${LocalKeys.CART_MESS.tr()}  ${snapshot.data['reedemablePoints'].toString()} ${LocalKeys.CART_MESS2.tr()}",
                                                  style: AppTheme.subHeading
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          spaceH(7),
                                          CartData(
                                            id: snapshot.data['_id'],
                                            name: snapshot.data['name'],
                                            price: snapshot.data['price'],
                                            url: snapshot.data['url'],
                                            width: 317,
                                            width2: 150.0,
                                            inCart: false,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        spaceH(10),
                        Container(
                          width: 300,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocalKeys.PRODUCT_DETAIL.tr(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: customColor)),
                              spaceH(10),
                              ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snapshot.data['attrs'].length,
                                  itemBuilder: (context, index) {
                                    return _product_description(
                                        snapshot.data['attrs'][index]['key'] +
                                            " : ",
                                        snapshot.data['attrs'][index]['value']);
                                  })
                            ],
                          ),
                        ),
                        spaceH(10),
                        (snapshot.data['isOffer'] == true)
                            ? _more_product_pharmacy((apiLang() == 'en')
                                ? snapshot.data['companyAr']
                                : snapshot.data['company'])
                            : Container(),
                        spaceH(10),
                        (snapshot.data['isOffer'] == true)
                            ? Text(LocalKeys.OFFERS_MESS.tr(),
                                style: AppTheme.heading
                                    .copyWith(color: Colors.red))
                            : Container(),
                        spaceH(10),
                        AlternativeProductdetailScreen(
                            alternative: snapshot.data['alternatives']),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            CartBottomBar(cartItems: cartItems, cartTotal: cartTotal),
          ],
        ));
  }

  _product_description(String txt, String txt2) {
    return (txt2 == null || txt2 == "")
        ? Container()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(
                  FontAwesomeIcons.solidCircle,
                  color: customColor,
                  size: 10,
                ),
              ),
              spaceW(5),
              Text(
                txt ?? '',
                style: AppTheme.subHeadingColorBlue,
              ),
              SizedBox(
                  width: 185,
                  child: Text(
                    txt2 ?? '',
                    style: AppTheme.subHeading,
                  )),
            ],
          );
  }

  _more_product_pharmacy(String name) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            FontAwesomeIcons.motorcycle,
            color: Colors.yellow[900],
          ),
          Center(
            child: Text(
              'More offers from ${name} Pharmacy',
              style: AppTheme.subHeadingColorBlue,
            ),
          ),
          Center(
            child: InkWell(
              child: Icon(
                Icons.arrow_forward_ios,
                color: customColor,
                size: 25,
              ),
              onTap: () {
                ///TODO:
              },
            ),
          )
        ],
      ),
    );
  }
}
