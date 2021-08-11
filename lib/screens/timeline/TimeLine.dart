import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/home/homeClasses/cartItemBar.dart';
import 'package:konsolto/screens/timeline/phoneSheet.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/screens/product_detail_screen/product_detail_screen.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:expandable/expandable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  bool showPrescription = false;
  bool showLaboratory = false;
  bool scanRequest = false;
  List<dynamic> patientTimeLine;
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

  _getTimeLineData() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    final token = _sp.getString('userToken');
    final id = _sp.getString('userDbId');
    if (token != null) {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'lang': sendapiLang()
      };
//"https://api.konsolto.com/visits/all" to get data from api for time line like debug version
      var response = await http.get(
          Uri.parse("https://api.konsolto.com/visits/all/$id"),
          headers: requestHeaders);

      if (response != null) {
        print('this is the response ---------------------------- $response');
        if (response.body != 'Unauthorized') {
          var homeSectionsResponse = json.decode(response.body);
          if (homeSectionsResponse != null) {
            if (homeSectionsResponse['success'] == true) {
              print(
                  '---------------------this is paient data : ${homeSectionsResponse['data']['visits']}');
              var visits = homeSectionsResponse['data']['visits'];
              setState(() {
                patientTimeLine = visits;
              });
            }
          }

          print(
              '---------------------this is paient data ${this.patientTimeLine}');
        }
      }
    }
  }

  @override
  void initState() {
    this._getTimeLineData();
    _checkIfHasCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          LocalKeys.MY_HEALTH_TIMELINE.tr(),
          style: AppTheme.headingColorBlue,
        ),
      ),
      body: Stack(
        children: [
          (patientTimeLine != null)
              ? CustomTimeLine(timeLineData: this.patientTimeLine)
              : Container(),
          CartBottomBar(cartItems: cartItems, cartTotal: cartTotal),
        ],
      ),
    );
  }
}

class CustomTimeLine extends StatefulWidget {
  final List<dynamic> timeLineData;
  CustomTimeLine({Key key, this.timeLineData}) : super(key: key);
  @override
  _CustomTimeLineState createState() => _CustomTimeLineState();
}

class _CustomTimeLineState extends State<CustomTimeLine> {
  bool showPrescription = false;
  bool showLaboratory = false;
  bool scanRequest = false;
  @override
  Widget build(BuildContext context) {
    print('--------------this is widget data---------- ${widget.timeLineData}');
    if (widget.timeLineData != null) {
      if (widget.timeLineData.isEmpty) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("lib/images/timeline.png")),
              spaceH(20),
              Text(
                "${LocalKeys.EMPTYTIMELINE.tr()}",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: HexColor('#d0011a'),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      } else {
        return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.timeLineData.length,
            itemBuilder: (context, index) {
              return Column(children: [
                TimelineTile(
                  alignment: TimelineAlign.start,
                  afterLineStyle: LineStyle(color: Colors.white),
                  beforeLineStyle: LineStyle(color: Colors.white),
                  lineXY: .3,
                  isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    width: 70,
                    height: 70,
                    indicator: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.d().format(DateTime.parse(
                                widget.timeLineData[index]['createdAt'])),
                            style: AppTheme.heading.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            DateFormat.MMMM().format(DateTime.parse(
                                widget.timeLineData[index]['createdAt'])),
                            style: AppTheme.subHeading,
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                  endChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 50,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                          maxRadius: 20,
                          minRadius: 20,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            child: customCachedNetworkImage(
                                context: context,
                                url: widget.timeLineData[index]['doctor']
                                    ['url'],
                                fit: BoxFit.contain),
                          )),
                      title: Text(
                        widget.timeLineData[index]['doctor']['name'],
                        style: AppTheme.heading.copyWith(fontSize: 10),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          if (widget
                                  .timeLineData[index]['doctor']['clinicMobile']
                                  .length >
                              1) {
                            homeBottomSheet(
                              context: context,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: PhoneBottonSheet(
                                phoneList: widget.timeLineData[index]['doctor']
                                    ['clinicMobile'],
                              ),
                            );
                          } else {
                            launch(
                                "tel:${widget.timeLineData[index]['doctor']['clinicMobile'][0]}");
                          }
                        },
                        icon: Icon(
                          Icons.phone,
                          color: customColorRed,
                        ),
                      ),
                    ),
                  ),
                ),
                spaceH(10),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.timeLineData[index]['payload'].length,
                    itemBuilder: (context, payloadIndex) {
                      if (widget
                              .timeLineData[index]['payload'][payloadIndex]
                                  ['products']
                              .length >
                          0) {
                        return TimelineTile(
                          alignment: TimelineAlign.start,
                          afterLineStyle: LineStyle(color: Colors.white),
                          beforeLineStyle: LineStyle(color: Colors.white),
                          lineXY: .3,
                          isLast: (payloadIndex ==
                                  widget.timeLineData[index]['payload'].length -
                                      1)
                              ? true
                              : false,
                          indicatorStyle: IndicatorStyle(
                            width: 50,
                            height: 50,
                            indicator: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: customCachedNetworkImage(
                                  context: context,
                                  url: widget.timeLineData[index]['payload']
                                      [payloadIndex]['icon'],
                                  fit: BoxFit.contain),
                            ),
                            color: Colors.white,
                          ),
                          endChild: Container(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                              ),
                              child: Container(
                                child: expendable_list(
                                    context,
                                    widget.timeLineData[index]['payload']
                                        [payloadIndex]['type'],
                                    widget.timeLineData[index]['payload']
                                        [payloadIndex]['products']),
                              )),
                        );
                      }
                      if (widget
                              .timeLineData[index]['payload'][payloadIndex]
                                  ['data']
                              .length >
                          0) {
                        return TimelineTile(
                          alignment: TimelineAlign.start,
                          afterLineStyle: LineStyle(color: Colors.white),
                          beforeLineStyle: LineStyle(color: Colors.white),
                          lineXY: .3,
                          isLast: (payloadIndex ==
                                  widget.timeLineData[index]['payload'].length -
                                      1)
                              ? true
                              : false,
                          indicatorStyle: IndicatorStyle(
                            width: 50,
                            height: 50,
                            indicator: CircleAvatar(
                                maxRadius: 30,
                                minRadius: 30,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  child: customCachedNetworkImage(
                                      context: context,
                                      url: widget.timeLineData[index]['payload']
                                          [payloadIndex]['icon'],
                                      fit: BoxFit.contain),
                                )),
                            color: Colors.white,
                          ),
                          endChild: Container(
                            constraints: const BoxConstraints(
                              minHeight: 50,
                            ),
                            child: _expendable_text_timeline(
                                context,
                                widget.timeLineData[index]['payload']
                                    [payloadIndex]['type'],
                                widget.timeLineData[index]['payload']
                                    [payloadIndex]['data']),
                          ),
                        );
                      }
                      return Container();
                    })
              ]);
            });
      }
    }
  }

  // ignore: non_constant_identifier_names
  _expendable_text_timeline(BuildContext context, String title, List thisData
      // , String subtitle
      ) {
    return ExpandableNotifier(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: <Widget>[
                  ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              title,
                              style: AppTheme.heading.copyWith(fontSize: 10),
                            )),
                        collapsed: Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            "Tap To View",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.heading.copyWith(fontSize: 8),
                          ),
                        ),
                        expanded: Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: thisData.length,
                                itemBuilder: (context, dataIndex) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(thisData[dataIndex]['title']),
                                        (thisData[dataIndex]['comment'] != null)
                                            ? Container(
                                                height: 100,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.blue[200],
                                                ),
                                                child: Wrap(
                                                  children: [
                                                    Text(
                                                      thisData[dataIndex]
                                                          ['comment'],
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        spaceH(10),
                                      ]);
                                })),
                      ))
                ]))));
  }

  // ignore: non_constant_identifier_names
  expendable_list(BuildContext context, String title, List thisProducts
      // ,String subtitle
      ) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: true,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        title,
                        style: AppTheme.heading.copyWith(fontSize: 10),
                      )),
                  collapsed: Text(
                    "Tab To View",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.heading.copyWith(fontSize: 8),
                  ),
                  expanded: Container(
                    height: 400,
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: thisProducts.length,
                        itemBuilder: (context, productIndex) {
                          return (thisProducts.isEmpty)
                              ? Container()
                              : Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductdetailScreen(
                                                id: thisProducts[productIndex]
                                                    ['_id'],
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          thisProducts[
                                                                      productIndex]
                                                                  ['name'] ??
                                                              '',
                                                          style: AppTheme
                                                              .headingColorBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        thisProducts[
                                                                    productIndex]
                                                                [
                                                                'formQuantity'] ??
                                                            '',
                                                        style:
                                                            AppTheme.subHeading,
                                                      ),
                                                      spaceH(10),
                                                      Text(
                                                        (thisProducts[productIndex]
                                                                    ['price'] ==
                                                                null)
                                                            ? ''
                                                            : thisProducts[productIndex]
                                                                        [
                                                                        'price']
                                                                    .toString() +
                                                                ' EGP',
                                                        style: AppTheme
                                                            .subHeadingColorBlue,
                                                      ),
                                                      spaceH(10),
                                                    ],
                                                  ),
                                                  spaceW(20),
                                                  Expanded(
                                                    child: Container(
                                                      // height: 80,
                                                      width: 60,
                                                      child:
                                                          customCachedNetworkImage(
                                                        context: context,
                                                        url: thisProducts[
                                                                productIndex]
                                                            ['url'],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            spaceH(40),
                                            Divider(
                                              thickness: 1.0,
                                              color: customColorGray,
                                            ),
                                            spaceH(40)
                                          ],
                                        ),
                                      ),
                                    ),
                                    (thisProducts.length - 1 == productIndex)
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CartData(
                                                // timelineProduct: thisProducts,
                                                inCart: false,
                                                id: thisProducts[productIndex]
                                                    ['_id'],
                                                name: thisProducts[productIndex]
                                                    ['name'],
                                                price:
                                                    thisProducts[productIndex]
                                                        ['price'],
                                                oldprice:
                                                    thisProducts[productIndex]
                                                        ['oldPrice'],
                                                url: thisProducts[productIndex]
                                                    ['url'],
                                                width: 150.0,
                                                width2: 70.0,
                                              ),
                                              InkWell(
                                                  onTap: () => Share.share(
                                                      "Hey check ${thisProducts[productIndex]['name']} on Konsolto \n ${thisProducts[productIndex]['dynamicLink']}"),
                                                  child: Icon(
                                                    Icons.share,
                                                    color: Colors.black,
                                                  ))
                                            ],
                                          )
                                        : Container(),
                                  ],
                                );
                        }),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
