import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/network_sensitive.dart';
import 'package:konsolto/services/deep_link_service.dart';
import 'package:konsolto/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locator.dart';
import 'home/homeClasses/tapToSeeOffers.dart';
import 'onboarding/onboarding.dart';
import 'package:konsolto/models/user_data.dart';

class SplashScreen extends StatelessWidget {
  static final route = '/splashScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkSensitive(
        child: SplashScreenPage(),
      ),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  static bool slider = true;
  static void isSlider() {
    slider = !slider;
  }

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
 

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
      TapToSeeOffers.currentPosition = position;
        // TapToSeeOffers.hasLocation = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getlocation() async {
    Userdata.lang = await MySharedPreferences.getUserlong() ?? "null";
    Userdata.let = await MySharedPreferences.getUserLat() ?? 'null';
    Userdata.appLang = await MySharedPreferences.getAppLang() ?? 'en';
    SharedPreferences _sp = await SharedPreferences.getInstance();
    Userdata.asddres = await MySharedPreferences.getUserAddress() ?? 'null';
    if (_sp.getBool('onBoarding') == true) {
      setState(() {
        OnBoard.onBoarding = true;
      });
    }
    if (Userdata.asddres != null) {
      setState(() {
        //TapToSeeOffers. = true;
      });
    }
  }

  navFun(context) async {
    final DynamicLinkService _dynamicLinkService =
        locator<DynamicLinkService>();
    await _dynamicLinkService.handleDynamicLinks(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnBoard(),
      ),
    );
  }

  @override
  void initState() {
    this._getlocation();
    this._getCurrentLocation();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => navFun(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.white,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: (apiLang() == 'en')
                        ? Image.asset(
                            'lib/images/new-konsolto-logo-05.png',
                            width: 300,
                            height: 200,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'lib/images/new-konsolto-logo-04.png',
                            fit: BoxFit.contain,
                            width: 300,
                            height: 200,
                          )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  placemarkFromCoordinates(double latitude, double longitude) {}
}
