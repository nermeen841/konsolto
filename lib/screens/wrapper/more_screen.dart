import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/domain/user_orders/user_order_store.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/order_cart_tracking/mycart.dart';
import 'package:konsolto/screens/order_cart_tracking/track_order/order_status_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../sharedPreferences.dart';

class MoreSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhenRebuilderOr<UserOrdersStore>(
        initState: (context, rm) => rm.setState((s) => s.getUserorders()),
        observe: () => RM.get<UserOrdersStore>(),
        builder: (context, model) => MoreScreen(),
        onWaiting: () => Loading(),
        onError: (error) => IN.get<UserOrdersStore>().getUserorders() == null
            ? Text('$error')
            : MoreScreen(),
      ),
    );
  }
}

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final userorderModel = IN.get<UserOrdersStore>().userorderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          LocalKeys.PREVIOUS_ORDERS.tr(),
          style: AppTheme.headingColorBlue,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        primary: true,
        shrinkWrap: true,
        children: [
          (userorderModel.data.orders.isEmpty)
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Image.asset(
                          "lib/images/onOrders.png",
                        ),
                      ),
                      spaceH(20),
                      Text(
                        LocalKeys.EMPTYORDERS.tr(),
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: HexColor('#d0011a'),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: userorderModel.data.orders.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, index) {
                    MySharedPreferences.saveorderID(
                        userorderModel.data.orders[index].sId);
                    MySharedPreferences.saveorderNum(
                        userorderModel.data.orders[index].orderNumber);
                    MySharedPreferences.saveorderStatus(
                        userorderModel.data.orders[index].status);
                    MySharedPreferences.saveorderDate(
                        userorderModel.data.orders[index].createdAt);

                    return InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocalKeys.ORDER.tr() +
                                      " #" +
                                      userorderModel
                                          .data.orders[index].orderNumber,
                                  style: AppTheme.headingColorBlue,
                                ),
                                Container(
                                  height: 23,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  color: (userorderModel
                                              .data.orders[index].status ==
                                          'Delivered')
                                      ? Colors.greenAccent[400]
                                      : (userorderModel
                                                  .data.orders[index].status ==
                                              'OnTheway')
                                          ? Colors.lightBlueAccent[100]
                                          : (userorderModel.data.orders[index]
                                                      .status ==
                                                  'OnHold')
                                              ? Colors.lightBlueAccent[100]
                                              : (userorderModel
                                                          .data
                                                          .orders[index]
                                                          .status ==
                                                      'Expired')
                                                  ? Colors.red[300]
                                                  : Colors.yellowAccent[100],
                                  child: Center(
                                    child: Text(
                                      userorderModel.data.orders[index].status,
                                      style: AppTheme.subHeading
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat.d().format(DateTime.parse(userorderModel
                                          .data.orders[index].createdAt)) +
                                      " " +
                                      DateFormat.MMMM().format(DateTime.parse(
                                          userorderModel
                                              .data.orders[index].createdAt)) +
                                      " " +
                                      DateFormat.y().format(DateTime.parse(userorderModel
                                          .data.orders[index].createdAt)) +
                                      " " +
                                      DateFormat.Hm().format(DateTime.parse(
                                          userorderModel.data.orders[index].createdAt)),
                                  style: AppTheme.subHeading,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: InkWell(
                                      child: Image.asset(
                                        "lib/images/phone-call.png",
                                        color: Colors.blue[300],
                                        width: 23,
                                        height: 23,
                                      ),
                                      onTap: () {
                                        launch("tel://21213123123");
                                      }),
                                )
                              ],
                            ),
                            spaceH(15),
                            (userorderModel.data.orders[index].status ==
                                        'Delivered' ||
                                    userorderModel.data.orders[index].status ==
                                        'Expired')
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MycartPage()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.red[200]),
                                          child: Center(
                                            child: Text(
                                              LocalKeys.REORDER_BUTTON.tr(),
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            launch("tel://21213123123"),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: customColor),
                                          child: Center(
                                            child: Text(
                                              LocalKeys.COMPLAINT_BUTTON.tr(),
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderStatusScreen(
                                      orderId:
                                          userorderModel.data.orders[index].sId,
                                    )));
                      },
                    );
                  })
        ],
      ),
    );
  }
}
