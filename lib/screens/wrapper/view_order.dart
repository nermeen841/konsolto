import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/screens/order_cart_tracking/oderStatusApi.dart';

class VieworderScreen extends StatefulWidget {
  String orderId;
  VieworderScreen({Key key, @required this.orderId}) : super(key: key);
  @override
  _VieworderScreenState createState() => _VieworderScreenState();
}

class _VieworderScreenState extends State<VieworderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            LocalKeys.VIEW_ORDER.tr(),
            style: AppTheme.headingColorBlue,
          ),
        ),
        body: ListView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            primary: true,
            shrinkWrap: true,
            children: [
              FutureBuilder(
                  future: OrderDetailApi.singleOrderdatail(widget.orderId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data['details'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _commen_cont(
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                    width: 80,
                                    // height: 80,
                                    child: customCachedNetworkImage(
                                      context: context,
                                      fit: BoxFit.contain,
                                      url: snapshot.data['details'][index]
                                          ['product']['url'],
                                    ),
                                  )),
                                  spaceW(10),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: (apiLang() == 'en')
                                              ? Text(
                                                  snapshot.data['details']
                                                              [index]
                                                              ['quantity']
                                                          .toString() +
                                                      "x " +
                                                      snapshot.data['details']
                                                              [index]['product']
                                                          ['nameArabic'],
                                                  style: AppTheme.heading
                                                      .copyWith(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                )
                                              : Text(
                                                  snapshot.data['details']
                                                              [index]
                                                              ['quantity']
                                                          .toString() +
                                                      "x " +
                                                      snapshot.data['details']
                                                              [index]['product']
                                                          ['name'],
                                                  style: AppTheme.heading
                                                      .copyWith(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                        ),
                                        spaceH(10),
                                        SizedBox(
                                          width: 170,
                                          child: Text(
                                              snapshot.data['details'][index]
                                                      ['product']['slug'] ??
                                                  "",
                                              style:
                                                  AppTheme.subHeading.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[700],
                                              )),
                                        ),
                                        spaceH(10),
                                        Text(
                                            snapshot.data['details'][index]
                                                        ['product']['price']
                                                    .toStringAsFixed(2) +
                                                " ${LocalKeys.EGP.tr()}",
                                            style:
                                                AppTheme.subHeadingColorBlue),
                                        spaceH(10),
                                        Center(
                                          child: Text(
                                            snapshot.data['status'],
                                            style: AppTheme.subHeadingColorBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Colors.transparent);
                        },
                      );
                    } else {
                      return Center(
                        child: Loading(),
                      );
                    }
                  })
            ]));
  }

  _commen_cont(Widget child, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: EdgeInsets.only(top: 7, bottom: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey[300]),
      ),
      child: child,
    );
  }
}
