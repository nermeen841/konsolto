import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:konsolto/notfications/notification_screen.dart';
import 'package:konsolto/screens/home/homeBottonSheet.dart';
import 'package:konsolto/screens/home/homeClasses/featuredBrandes.dart';
import 'package:konsolto/screens/home/homeClasses/tapToSeeOffers.dart';
import 'package:konsolto/screens/home/homeSlidder.dart';
import 'package:konsolto/screens/home/homeClasses/cartItemBar.dart';
import 'package:konsolto/screens/home/homeSearch.dart';
import 'package:konsolto/screens/testUserAddressTRack/userAddresstrack.dart';
import 'package:konsolto/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeClasses/featuredOffers.dart';
import 'homeClasses/homePaner.dart';
import 'homeClasses/offersNearyou/offertsNears.dart';
import 'homeClasses/pharmacyCategories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_order_container.dart';

class SilverTest extends StatefulWidget {
  @override
  _SilverTestState createState() => _SilverTestState();
}

class _SilverTestState extends State<SilverTest> {
  bool haveOffers = false;
  bool haveVisitData = false;
  List<dynamic> homeSections;
  bool hasCart = false;
  String cartTotal;
  String cartItems;
  double _long;
  double _late;

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

  getUserAddres() async {
    SharedPreferences address = await SharedPreferences.getInstance();
    Userdata.asddres = address.getString('address') ?? 'null';
  }

  // ignore: unused_element
  _theMap() async {
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _long = position.longitude;
        _late = position.latitude;
        TapToSeeOffers.currentPosition = position;
      });
      MySharedPreferences.saveUserlong(_long.toString());
      MySharedPreferences.saveUserlat(_late.toString());
    });
  }

  _getSectionsForHome() async {
    Userdata.asddres = await MySharedPreferences.getUserAddress();
    Userdata.lang = await MySharedPreferences.getUserlong() ?? 'null';
    Userdata.lang = await MySharedPreferences.getUserLat() ?? 'null';
    SharedPreferences _sp = await SharedPreferences.getInstance();
    Map<String, String> _body = {
      'token': _sp.getString('userToken'),
      'long': _sp.getString('long'),
      'lat': _sp.getString('late')
    };
    //
    var response =
        await http.get(Uri.parse(Utils.HOME_SECTIONS_URL), headers: _body);
    var homeSectionsResponse = json.decode(response.body);
    if (homeSectionsResponse != null) {
      setState(() {
        homeSections = homeSectionsResponse['data']['sections'];
      });
    }
    setState(() {
      haveOffers = true;
    });
    if (_sp.getString('long') != null && _sp.getString('late') != null) {
      setState(() {
        haveOffers = true;
      });
    }

    print(this.homeSections);
  }

  @override
  void initState() {
    this._getSectionsForHome();
    this.getUserAddres();
    this._checkIfHasCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: customColor,
          automaticallyImplyLeading: false,
        ),
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
              return <Widget>[
                sliver_appbar_logo(),
                sliver_appbar_text(),
                sliver_search_appbar()
              ];
            },
            body: Stack(
              children: [
                (this.homeSections != null)
                    ? ListView(
                        shrinkWrap: true,
                        primary: true,
                        children: [
                          HomePaner(),
                          (TapToSeeOffers.currentPosition == null)
                              ? TapToSeeOffers()
                              : Container(),
                          HomeOrder(),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: this.homeSections.length,
                            itemBuilder: (context, index) {
                              //if type is pharmacies
                              if (this.homeSections[index]["type"] ==
                                  'Pharmacies') {
                                //display home offers if exist
                                if (this.homeSections[index]['Pharmacies'] !=
                                    null) {
                                  return OffersNearYou(
                                      homeSections: this.homeSections,
                                      thisIndex: index);
                                }
                              }
                              //if type is Slider
                              if (this.homeSections[index]["type"] ==
                                  'Slider') {
                                if (this.homeSections[index]['sliders'] !=
                                    null) {
                                  return HomeSlidder(
                                      homeSections: this.homeSections,
                                      thisIndex: index);
                                }
                              }

                              //if type is Category
                              if (this.homeSections[index]["type"] ==
                                  'Categories') {
                                if (this.homeSections[index]['categories'] !=
                                    null) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: PharmacyCategaorises(
                                        homeSections: this.homeSections,
                                        thisIndex: index),
                                  );
                                }
                              }
                              //if type is Products
                              if (this.homeSections[index]["type"] ==
                                  'Products') {
                                if (this.homeSections[index]['products'] !=
                                    null) {
                                  return Container(
                                    // height: 390,
                                    child: Featuredoffers(
                                        homeSections: this.homeSections,
                                        thisIndex: index),
                                  );
                                }
                              }
                              //if type is Prands
                              if (this.homeSections[index]["type"] ==
                                  'Brands') {
                                if (this.homeSections[index]['brands'] !=
                                    null) {
                                  return Container(
                                      height: 350,
                                      child: FeaturedBrandes(
                                          homeSections: this.homeSections,
                                          thisIndex: index));
                                }
                              }
                              return Container();
                            },
                          ),
                        ],
                      )
                    : Container(),
                //check if user have cart
                CartBottomBar(cartItems: cartItems, cartTotal: cartTotal)
              ],
            )));
  }

  // ignore: non_constant_identifier_names
  sliver_appbar_logo() {
    return SliverAppBar(
      floating: false,
      elevation: 0.0,
      expandedHeight: 70,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (apiLang() == 'en')
                    ? Center(
                        child: Image.asset(
                          'lib/images/new-konsolto-logo-05.png',
                          width: 180,
                          // height: 50,
                        ),
                      )
                    : Center(
                        child: Image.asset(
                          'lib/images/new-konsolto-logo-04.png',
                          width: 180,
                          // height: 50,
                        ),
                      ),
                Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NotificationScreenPage(),
                        ),
                      );
                    },
                  ),
                )
              ]),
        );
      }),
    );
  }

  // ignore: non_constant_identifier_names
  sliver_appbar_text() {
    return SliverAppBar(
      floating: false,
      elevation: 0.0,
      expandedHeight: 35,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Color(0xffff1f1f1),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return InkWell(
            onTap: () {
              // if (_late == 'null' && _long == 'null') {
              //   _theMap();
              // } else {
              homeBottomSheet(
                context: context,
                child: HomeBottomSheet(),
              );
              //   }
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: customColorGray,
              padding: EdgeInsets.only(top: 5, left: 5, right: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 20,
                          ),
                          // SizedBox(width: 5),
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            padding: EdgeInsets.only(top: 5),
                            child: SizedBox(height: 20, child: DashboardScreen()
                                // (SilverTest.userAdress == null)
                                //     ? Text(
                                //         homeAddres(),
                                //         style: AppTheme.subHeadingColorBlue,
                                //       )
                                //     :
                                //  Text(
                                //     SilverTest.userAdress,
                                //     style: AppTheme.subHeadingColorBlue,
                                //   ),
                                ),
                          ),
                        ],
                      ),
                      Icon(
                        FontAwesomeIcons.angleDown,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  homeAddres() {
    if (Userdata.asddres == 'null' || Userdata.asddres == null) {
      return '';
    } else {
      if (Userdata.asddres.length > 45) {
        return Userdata.asddres.substring(0, 45) + ".....";
      } else {
        return Userdata.asddres;
      }
    }
  }

  // ignore: non_constant_identifier_names
  sliver_search_appbar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 40,
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xffff1f1f1),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: HomeSearch(),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: customColor2,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Center(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            LocalKeys.SEARCH_MESS_HINT.tr(),
                            style: AppTheme.subHeadingColorBlue.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ]),
                ),
              ));
        },
      ),
    );
  }
}
