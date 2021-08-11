import 'package:flutter/material.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/delivery_screens/check_out_data.dart';
import 'package:konsolto/screens/order_cart_tracking/carSearch.dart';
import 'package:konsolto/screens/order_cart_tracking/oderStatusApi.dart';
import 'package:konsolto/screens/order_cart_tracking/track_order/canceled_emoji_class.dart';
import 'package:konsolto/screens/order_cart_tracking/track_order/rating_pharmacy.dart';
import 'package:konsolto/screens/wrapper/view_order.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'pharmacy_delivery_note.dart';
import 'order_usage_button.dart';
import 'timeline_order_track.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class OrderStatusScreen extends StatefulWidget {
  String orderId;
  OrderStatusScreen({Key key, @required this.orderId}) : super(key: key);
  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          LocalKeys.VIEW_ORDER.tr(),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: OrderDetailApi.singleOrderdatail(widget.orderId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Text(OrderDetailApi.error),
                  ),
                );
              }
              if (snapshot.data != null) {
                return ListView(
                  primary: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalKeys.ORDER.tr() +
                              " #" +
                              "${snapshot.data['orderNumber']}",
                          style: AppTheme.headingColorBlue,
                        ),
                        (snapshot.data['status'].toString() == "Cancelled" ||
                                snapshot.data['status'].toString() ==
                                    'Expired' ||
                                snapshot.data['status'].toString() ==
                                    'Delivered')
                            ? InkWell(
                                onTap: () {
                                  RM.navigate.to(MycartPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      LocalKeys.REORDER_BUTTON.tr(),
                                      style: AppTheme.heading
                                          .copyWith(color: Colors.red),
                                    ),
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                    spaceH(10),
                    _commen_cont(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocalKeys.ORDER_STATUSE.tr(),
                                  style: AppTheme.heading,
                                ),
                                spaceW(10),
                                Text(
                                  snapshot.data['status'].toString(),
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                            spaceH(10),
                            Center(
                              child: Text(
                                (apiLang() == 'en')
                                    ? snapshot.data['statusMsg'].toString()
                                    : snapshot.data['statusMsg'].toString(),
                                style: AppTheme.subHeadingColorBlue,
                              ),
                            )
                          ],
                        ),
                        Colors.transparent),
                    // spaceH(10),
                    (snapshot.data['status'].toString() == "Cancelled" ||
                            snapshot.data['status'].toString() == "Expired" ||
                            snapshot.data['status'].toString() == "OnHold")
                        ? Container()
                        : TimelineOrderTrack(
                            orderStatuse: snapshot.data['status'].toString(),
                          ),

                    (snapshot.data['status'].toString() == "Cancelled" ||
                            snapshot.data['status'].toString() == "Expired")
                        ? CancelledSademoji()
                        : Container(),

                    (snapshot.data['status'].toString() == "OnHold")
                        ? Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.handSparkles,
                                  color: customColor,
                                  size: 50,
                                ),
                                spaceH(10),
                                Center(
                                  child: Text(
                                    "${LocalKeys.ONHOLD.tr()}",
                                    style: AppTheme.headingColorBlue,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    spaceH(10),
                    (snapshot.data['status'].toString() == "Delivered")
                        ? OrderusageButton(
                            usageInstruction: (apiLang() == 'en')
                                ? snapshot.data['howToUseAr']
                                : snapshot.data['howToUse'])
                        : Container(),
                    spaceH(10),
                    (snapshot.data['status'] == "Delivered")
                        ? RatingPharmacyScreen(
                            statusMsg: snapshot.data['statusMsg'].toString(),
                            rating: double.parse(
                                snapshot.data['rating'].toString()),
                          )
                        : Container(),
                    spaceH(10),
                    (snapshot.data['status'] == "Delivered" ||
                            snapshot.data['status'] == "OnTheWay")
                        ? PharmacydeliveryNote(
                            data: snapshot.data['pharmacy'],
                            note: snapshot.data['note'],
                            pharmacyMsg: snapshot.data['statusMsg'],
                          )
                        : Container(),
                    _commen_container(
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.menu,
                                  color: customColor,
                                ),
                                spaceW(10),
                                Container(
                                  width: 286,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data['details'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (apiLang() == 'en')
                                          ? Text(
                                              snapshot.data['details'][index]
                                                              ['quantity']
                                                          .toString() +
                                                      "x " +
                                                      snapshot.data['details']
                                                              [index]['product']
                                                              ['nameArabic']
                                                          .toString() ??
                                                  "",
                                              style: AppTheme.subHeading,
                                            )
                                          : Text(
                                              snapshot.data['details'][index]
                                                              ['quantity']
                                                          .toString() +
                                                      "x " +
                                                      snapshot.data['details']
                                                              [index]['product']
                                                              ['name']
                                                          .toString() ??
                                                  "",
                                              style: AppTheme.subHeading,
                                            );
                                    },
                                  ),
                                )
                              ],
                            ),
                            spaceH(10),
                            Align(
                              alignment: (apiLang() == 'en')
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              // padding: EdgeInsets.only(left: 200),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VieworderScreen(
                                                orderId: snapshot.data['_id']
                                                    .toString(),
                                              )));
                                },
                                child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        LocalKeys.VIEW_DETAIL_BUTTON.tr(),
                                        style: AppTheme.subHeadingColorBlue,
                                      ),
                                    )),
                              ),
                            )
                          ]),
                    ),
                    spaceH(10),
                    (snapshot.data['address'] == null)
                        ? Container()
                        : Text(
                            LocalKeys.DELIVERY_ADDRESS.tr(),
                            style: AppTheme.headingColorBlue,
                          ),
                    spaceH(10),
                    (snapshot.data['address'] == null)
                        ? Container()
                        : _commen_container(Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.mapMarker,
                                    size: 15,
                                  ),
                                  spaceW(5),
                                  Expanded(
                                    child: Text(
                                      snapshot.data['address']['address'],
                                      style: AppTheme.subHeadingColorBlue,
                                    ),
                                  )
                                ],
                              ),
                              spaceH(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.black,
                                  ),
                                  spaceW(5),
                                  Text(
                                    LocalKeys.BULD_NUM.tr() +
                                            " :" +
                                            snapshot.data['address']
                                                ['buildingNo'] ??
                                        "" +
                                            "\n" +
                                            LocalKeys.APARTMENT.tr() +
                                            " : " +
                                            snapshot.data['address']['flat'] ??
                                        "" +
                                            "\n" +
                                            LocalKeys.FLOOR_NUM.tr() +
                                            ": " +
                                            snapshot.data['address']['floor'] ??
                                        "",
                                    style: AppTheme.subHeading,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                              spaceH(10),
                              (snapshot.data['address']['mobile'] == null)
                                  ? Container()
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                        ),
                                        spaceW(5),
                                        Text(
                                          snapshot.data['address']['mobile']
                                              .toString(),
                                          style: AppTheme.subHeading,
                                        )
                                      ],
                                    ),
                            ],
                          )),

                    spaceH(10),
                    Text(
                      LocalKeys.PAYMENT_METHODE.tr(),
                      style: AppTheme.headingColorBlue,
                    ),
                    spaceH(10),
                    _commen_container(
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(
                              FontAwesomeIcons.solidCircle,
                              color: customColor,
                              size: 15,
                            ),
                          ),
                          spaceW(10),
                          Text(
                            LocalKeys.CASH_ON_DELIVERY.tr(),
                            style: AppTheme.headingColorBlue.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    spaceH(10),
                    (CheckoutDataScreen.promoDesc == null)
                        ? Container()
                        : _commen_container(Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: customColorGreen,
                                      size: 20,
                                    ),
                                  ),
                                  spaceW(5),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Free ${CheckoutDataScreen.discount}",
                                      style: AppTheme.heading
                                          .copyWith(color: customColorGreen),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Text("${CheckoutDataScreen.promoDesc}"),
                              ),
                            ],
                          )),
                    spaceH(10),
                    _commen_container(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocalKeys.SUB_TOTAL.tr(),
                              style: AppTheme.subHeading,
                            ),
                            Text(
                              snapshot.data['totalPrice'].toStringAsFixed(2) +
                                  LocalKeys.EGP.tr(),
                              style: AppTheme.subHeading,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocalKeys.DELIVERY_FEES.tr(),
                              style: AppTheme.subHeading,
                            ),
                            Text(
                              snapshot.data['deliveryFees'].toString() +
                                  LocalKeys.EGP.tr(),
                              style: AppTheme.subHeading,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (snapshot.data['discount'] == null ||
                                    snapshot.data['discount'] == 0)
                                ? Container()
                                : Text(
                                    LocalKeys.DISCOUNT.tr(),
                                    style: AppTheme.subHeading
                                        .copyWith(color: Colors.red),
                                  ),
                            (snapshot.data['discount'] == null ||
                                    snapshot.data['discount'] == 0)
                                ? Container()
                                : Text(
                                    snapshot.data['discount'].toString() +
                                        LocalKeys.EGP.tr(),
                                    style: AppTheme.subHeading
                                        .copyWith(color: Colors.red),
                                  )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocalKeys.TOTAL.tr(),
                              style: AppTheme.heading,
                            ),
                            Text(
                              snapshot.data['totalPrice'].toStringAsFixed(2) +
                                  LocalKeys.EGP.tr(),
                              style: AppTheme.heading,
                            )
                          ],
                        ),
                      ],
                    )),
                    spaceH(10),
                    _commen_cont(
                        InkWell(
                            onTap: () => Freshchat.showConversations(),
                            child: Center(
                              child: Text(
                                LocalKeys.SUPPORTBUTTON.tr(),
                                style: AppTheme.heading,
                              ),
                            )),
                        Colors.white30),

                    spaceH(10),
                    _commen_button(),
                  ],
                );
              } else {
                return Container();
              }
            } else {
              return Center(child: Loading());
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  _commen_cont(Widget child, Color color) {
    return Container(
      // height: x,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey[300]),
      ),
      child: child,
    );
  }

  // ignore: non_constant_identifier_names
  _commen_container(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

// Mark as delivered button
  // ignore: non_constant_identifier_names
  _commen_button() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: customColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            LocalKeys.DELIVERED_BUTTON.tr(),
            style: AppTheme.heading.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
