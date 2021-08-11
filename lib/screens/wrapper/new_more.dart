import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/domain/user_profile/user_profile_store.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/models/pointMarketApi.dart';
import 'package:konsolto/models/singlepointMarket.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:konsolto/screens/delivery_screens/my_address_screen.dart';
import 'package:konsolto/screens/discount_screens/monthly_disc_report.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:konsolto/screens/home/homeClasses/cartItemBar.dart';
import 'package:konsolto/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../../sharedPreferences.dart';
import 'more_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class NewMorePage extends StatelessWidget {
  static String localLang;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhenRebuilderOr<ProfiledataStore>(
        initState: (context, rm) => rm.setState((s) => s.getProfiledata()),
        observe: () => RM.get<ProfiledataStore>(),
        builder: (context, model) => NewMore(),
        onWaiting: () => Loading(),
        onError: (error) => IN.get<ProfiledataStore>().getProfiledata() == null
            ? Text('$error')
            : NewMore(),
      ),
    );
  }
}

class NewMore extends StatefulWidget {
  @override
  _NewMoreState createState() => _NewMoreState();
}

class _NewMoreState extends State<NewMore> {
  final userprofileModel = IN.get<ProfiledataStore>().userprofileModel;

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

  @override
  void initState() {
    this._checkIfHasCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Provider.of<HomeAddressProvider>(context).isAddNewAdress)
        ? Container()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 0.0,
            ),
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    primary: true,
                    shrinkWrap: true,
                    children: [
                      _commen_container(
                          10,
                          customColor,
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: customColor, shape: BoxShape.circle),

                                ///TODO: ADD CIRCULAR AVATER
                              ),
                              Column(
                                children: [
                                  Text(
                                    userprofileModel.data.patient.name,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  spaceH(5),
                                  Container(
                                    // width: 100,
                                    // height: 20,
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[200],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      "${userprofileModel.data.patient.point.availableAmount}  POINTS",
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: customColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                      spaceH(10),
                      Text(
                        LocalKeys.GENERAL.tr(),
                        style: AppTheme.headingColorBlue,
                      ),
                      spaceH(10),
                      //////////////////////////////////////////////////////////GENERAL BOTTOMSHEET DATA
                      _commen_container(
                          10,
                          Colors.white,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MoreSPage()));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.cube,
                                          color: customColor,
                                          size: 20,
                                        ),
                                        spaceW(7),
                                        Text(
                                          LocalKeys.MY_ORDERS.tr(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: customColor),
                                        ),
                                      ],
                                    )),
                                spaceH(30),
                                InkWell(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.syncAlt,
                                        color: customColor,
                                        size: 20,
                                      ),
                                      spaceW(7),
                                      Text(
                                        LocalKeys.MONTHLY_ORDERS.tr(),
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: customColor),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MonthlyReportDiscount(),
                                        ));
                                  },
                                ),
                                spaceH(30),
                                InkWell(
                                    onTap: () {
                                      showSettingsPanel(
                                        scroll: false,
                                        context: context,
                                        child: Container(
                                            height: 350,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 50, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Image.asset(
                                                    "lib/images/creditcard.png",
                                                    width: 150,
                                                    height: 150,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                spaceH(20),
                                                Center(
                                                  child: Text(
                                                    "You have ${userprofileModel.data.patient.wallet.availableAmount} ${LocalKeys.EGP.tr()} Konsolto credit",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: customColor),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "lib/images/creditcard.png",
                                          width: 25,
                                          height: 25,
                                        ),
                                        spaceW(7),
                                        Text(
                                          LocalKeys.CREDIT.tr(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: customColor),
                                        ),
                                      ],
                                    )),
                                spaceH(30),
                                InkWell(
                                    onTap: () {
                                      showSettingsPanel(
                                        scroll: true,
                                        context: context,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "lib/images/inviteyourfriends.png",
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.contain,
                                              ),
                                              spaceH(20),
                                              Container(
                                                width: 140,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: customColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    userprofileModel.data
                                                        .patient.referralCode
                                                        .toString(),
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: customColor),
                                                  ),
                                                ),
                                              ),
                                              spaceH(10),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.blue[100],
                                                ),
                                                child: Wrap(
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      parseHtmlString(
                                                          userprofileModel
                                                              .data
                                                              .patient
                                                              .referralMsg),
                                                      style: AppTheme
                                                          .headingColorBlue,
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              spaceH(15),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 16,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color:
                                                            Colors.blue[100]),
                                                  ),
                                                  spaceW(7),
                                                  Text(
                                                    LocalKeys
                                                        .POINTS_FROM_SIGNED_FRIENDS
                                                        .tr(),
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: customColor),
                                                  ),
                                                ],
                                              ),
                                              spaceH(10),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 16,
                                                    width: 30,
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color:
                                                            Colors.blue[100]),
                                                  ),
                                                  spaceW(7),
                                                  Text(
                                                    LocalKeys
                                                        .CREDIT_FRIEND_ORDER
                                                        .tr(),
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: customColor),
                                                  ),
                                                ],
                                              ),
                                              spaceH(20),
                                              InkWell(
                                                onTap: () {
                                                  Share.share(userprofileModel
                                                      .data
                                                      .patient
                                                      .referralChatMSG);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: customColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      LocalKeys.SHARE_FOR_MORE
                                                          .tr(),
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.shareAlt,
                                          color: customColor,
                                          size: 20,
                                        ),
                                        spaceW(7),
                                        Text(
                                          LocalKeys.INVITE_YOUR_FRIENDS.tr(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: customColor),
                                        ),
                                      ],
                                    )),
                                spaceH(30),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyAddressScreen()));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.mapMarkedAlt,
                                            size: 20, color: customColor),
                                        spaceW(7),
                                        Text(
                                          LocalKeys.MY_ADDRESSE.tr(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: customColor),
                                        ),
                                      ],
                                    )),
                                spaceH(30),
                                InkWell(
                                    onTap: () {
                                      showSettingsPanel(
                                          scroll: true,
                                          context: context,
                                          child: _point_market_container());
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'lib/images/product_detail_cutIcon.png',
                                          width: 23,
                                          height: 23,
                                        ),
                                        spaceW(7),
                                        Text(
                                          LocalKeys.POINT_MARKET.tr(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor("#FFCA28")),
                                        ),
                                      ],
                                    )),

                                // InkWell(
                                //     onTap: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   NotificationScreenPage()));
                                //     },
                                //     child: Row(
                                //       children: [
                                //         Icon(FontAwesomeIcons.bell,
                                //             size: 20, color: Colors.blue[200]),
                                //         spaceW(7),
                                //         Text(
                                //           LocalKeys.NOTIFICATION.tr(),
                                //           style: GoogleFonts.roboto(
                                //               fontSize: 12,
                                //               fontWeight: FontWeight.w400,
                                //               color: customColor),
                                //         ),
                                //       ],
                                //     )),
                              ])),

                      spaceH(10),
                      Text(
                        LocalKeys.SETTING.tr(),
                        style: AppTheme.headingColorBlue,
                      ),
                      spaceH(10),
                      _commen_container(
                          10,
                          Colors.white,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    setState(() {
                                      MySharedPreferences.saveAppLang(
                                          LocalKeys.LANG_API_EXCHANGE.tr());
                                      MySharedPreferences.saveApiLang(
                                          LocalKeys.API_LANG.tr());
                                      context.locale = Locale(
                                          LocalKeys.LANG_API_EXCHANGE.tr());
                                    });
                                    Userdata.apiLang =
                                        await MySharedPreferences.getApiLang();
                                    Userdata.appLang =
                                        await MySharedPreferences.getAppLang();
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "lib/images/global.png",
                                        color: customColor,
                                        width: 20,
                                        height: 20,
                                      ),
                                      spaceW(5),
                                      Text(
                                        LocalKeys.LANG_BUTTON_EXCHANGE.tr(),
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                              spaceH(15),
                              InkWell(
                                  onTap: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    await pref.clear();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext ctx) =>
                                                SplashScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "lib/images/logout.png",
                                        color: customColor,
                                        width: 20,
                                        height: 20,
                                      ),
                                      spaceW(5),
                                      Text(
                                        LocalKeys.LOG_OUT.tr(),
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
                CartBottomBar(cartItems: cartItems, cartTotal: cartTotal)
              ],
            ),
          );
  }

  _commen_container(double y, Color color, Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(y), color: color),
      child: child,
    );
  }

  _point_market_container() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: FutureBuilder(
          future: PointMarketApi.pointMarketdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (apiLang() == 'en')
                                ? Text(
                                    snapshot.data[index]['title'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: customColor),
                                  )
                                : Text(
                                    snapshot.data[index]['title_AR'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: customColor),
                                  ),
                            Container(
                              height: 16,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: HexColor("#FFCA28"),
                              ),
                              child: Center(
                                child: Text(
                                  "${snapshot.data[index]['requiredPoints']} Points",
                                  style: GoogleFonts.roboto(
                                      color: customColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ]),
                      (apiLang() == 'en')
                          ? Text(
                              snapshot.data[index]['description'],
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: customColor),
                            )
                          : Text(
                              snapshot.data[index]['description_AR'],
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: customColor),
                            ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: customCachedNetworkImage(
                            context: context,
                            url: snapshot.data[index]['picture'],
                            fit: BoxFit.cover),
                      ),
                      spaceH(15),
                      InkWell(
                        onTap: () {
                          singlePointMarket(
                            id: snapshot.data[index]['_id'],
                            description: snapshot.data[index]['howToRedeem'],
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              snapshot.data[index]['howToRedeem'],
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: customColor),
                            )),
                            Container(
                              height: 16,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: HexColor("#FFCA28"),
                              ),
                              child: Center(
                                child: Text(
                                  "${snapshot.data[index]['requiredPoints']} Points",
                                  style: GoogleFonts.roboto(
                                      color: customColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceH(20)
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  singlePointMarket({String id, String description}) {
    return showSettingsPanel(
        context: context,
        scroll: true,
        child: FutureBuilder(
          future: SinglePointMarketApi.singlepointMarketdata(id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("lib/images/sad.png"),
                      spaceH(20),
                      Text(
                        SinglePointMarketApi.error,
                        style: AppTheme.headingColorBlue,
                      ),
                    ],
                  ));
            } else {
              if (snapshot.hasData) {
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("lib/images/pointvounchermarket.png"),
                            spaceH(10),
                            // ${snapshot.data['subtracted']}
                            Text(
                              "You have redeemed  Points for",
                              style: AppTheme.headingColorBlue,
                            ),
                            spaceH(10),
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                description,
                                style: AppTheme.subHeadingColorBlue,
                              ),
                            ),
                            spaceH(10),
                            // ${snapshot.data['point']['availableAmount']}
                            Text(
                              "You have  points left",
                              style: AppTheme.subHeading,
                            ),
                            spaceH(20),
                            // (snapshot.data['description'] == null)
                            //     ? Container()
                            //     :
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[200],
                              ),
                              child: Text(
                                "snapshot.data['description']",
                                style: AppTheme.subHeading,
                              ),
                            ),
                            spaceH(20),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  color: customColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    LocalKeys.DONE_BUTTON.tr(),
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ));
              } else {
                return Center(
                  child: Loading(),
                );
              }
            }
          },
        ));
  }
}
