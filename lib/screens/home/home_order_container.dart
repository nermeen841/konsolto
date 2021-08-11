import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:konsolto/screens/home/userOrder.dart';
import 'package:konsolto/screens/order_cart_tracking/track_order/order_status_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeOrder extends StatefulWidget {
  @override
  _HomeOrderState createState() => _HomeOrderState();
}

class _HomeOrderState extends State<HomeOrder> {
  TextEditingController ratingController = TextEditingController();
  bool loading = false;
  double reting = 0.0;
  String error;
  String orderId;
  bool visible = true;
  ratingOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'lang': apiLang(),
      };
      var _body = jsonEncode({
        "_id": orderId,
        "rating": (reting.toInt()).toString(),
      });
      print(
          "___________________________________________________ ORDER ID: $orderId");
      print(
          "___________________________________________________ ORDER RATING : ${(reting.toInt()).toString()}");
      var response = await http.put(Uri.parse(Utils.RATING_ORDER),
          headers: requestHeaders, body: _body);
      var _data = json.decode(response.body);
      print(_data);
      if (_data['success'] == true) {
        setState(() {
          visible = false;
        });
      }
    } catch (e) {
      setState(() {
        visible = true;
      });
      print(
          '_________________________________________________________________ ORDER ERROR :   $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: FutureBuilder(
          future: UserOrdersApi.userOrdersApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0]['status'] == 'Cancelled' ||
                  snapshot.data[0]['status'] == 'Expired') {
                return Container();
              }
              if (snapshot.data[0] != null ||
                  snapshot.data[0]['status'] != 'Cancelled' ||
                  snapshot.data[0]['status'] != 'Expired') {
                return Column(
                  children: [
                    (snapshot.data[0]['status'] == 'Delivered')
                        ? Visibility(
                            visible: visible,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocalKeys.ORDER.tr() +
                                              " " +
                                              "#" +
                                              snapshot.data[0]['orderNumber']
                                                  .toString(),
                                          style: AppTheme.headingColorBlue,
                                        ),
                                        Container(
                                          height: 23,
                                          color: Colors.greenAccent[400],
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Center(
                                            child: Text(
                                              snapshot.data[0]['status'],
                                              style: AppTheme.subHeading
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    spaceH(10),
                                    Center(
                                        child: SmoothStarRating(
                                            allowHalfRating: false,
                                            onRated: (v) {
                                              setState(() {
                                                reting = v;
                                                orderId =
                                                    snapshot.data[0]['_id'];
                                              });
                                            },
                                            starCount: 5,
                                            size: 40.0,
                                            isReadOnly: false,
                                            filledIconData: Icons.star,
                                            halfFilledIconData: Icons.blur_on,
                                            color: customColor,
                                            borderColor: customColorGray,
                                            spacing: 0.0)),
                                    spaceH(10),
                                    Container(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          color: customColorGray,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: ratingController,
                                        decoration: InputDecoration(
                                          hintText: '',
                                          border: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    (error == null)
                                        ? Container()
                                        : Center(child: Text(error)),
                                    Align(
                                      alignment: (Userdata.appLang == 'ar')
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      child: TextButton(
                                        child: Text(
                                            LocalKeys.SUBMIT_BUTTON.tr(),
                                            style: AppTheme.headingColorBlue),
                                        onPressed: () {
                                          ratingOrder();
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                        : InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocalKeys.ORDER.tr() +
                                            " #" +
                                            snapshot.data[0]['orderNumber'],
                                        style: AppTheme.headingColorBlue,
                                      ),
                                      Container(
                                        height: 23,
                                        //  width: 120,
                                        color: (snapshot.data[0]['status'] ==
                                                    'OnTheway' ||
                                                snapshot.data[0]['status'] ==
                                                    'OnHold')
                                            ? Colors.lightBlueAccent[100]
                                            : Colors.yellowAccent[100],
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Center(
                                          child: Text(
                                            snapshot.data[0]['status'],
                                            style: AppTheme.subHeading
                                                .copyWith(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat.d().format(DateTime.parse(
                                                snapshot.data[0]
                                                    ['createdAt'])) +
                                            " " +
                                            DateFormat.MMMM().format(
                                                DateTime.parse(snapshot.data[0]
                                                    ['createdAt'])) +
                                            " " +
                                            DateFormat.y().format(
                                                DateTime.parse(snapshot.data[0]
                                                    ['createdAt'])),
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
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => OrderStatusScreen(
                                        orderId: snapshot.data[0]['_id'],
                                      )));
                            },
                          ),
                  ],
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          },
        ));
  }

  // getOrderID() async {
  //   HomeOrder.orderId = await MySharedPreferences.getorderID() ?? "";
  // }
}
