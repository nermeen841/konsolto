import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../sharedPreferences.dart';

class TapToSeeOffers extends StatefulWidget {
  static Position currentPosition;
  @override
  _TapToSeeOffersState createState() => _TapToSeeOffersState();
}

class _TapToSeeOffersState extends State<TapToSeeOffers> {
  String _lat;
  String _log;
  double _long;

  double _late;
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        TapToSeeOffers.currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _checkIfHasLocation() async {
    _lat = MySharedPreferences.getUserLat() ?? 'null';
    _log = MySharedPreferences.getUserlong() ?? 'null';
    if (_log != 'null' && _lat != 'null') {
      setState(() {
        // TapToSeeOffers.hasLocation = true;
      });
    }
  }

  _theMap() async {
    await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        _long = value.longitude;
        _late = value.latitude;
      });
      MySharedPreferences.saveUserlong(_long.toString());
      MySharedPreferences.saveUserlat(_late.toString());
    });
  }

  @override
  void initState() {
    this._checkIfHasLocation();
    this._getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showMyOfferDialog(
          context: context,
          image: 'lib/images/Mediamodifier-Design-Template (3).png',
        );
      },
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // padding: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 175,
                width: 180,
                child: Image.asset(
                  'lib/images/Mediamodifier-Design-Template (3).png',
                  fit: BoxFit.fitHeight,
                )),
            spaceH(30),
            SizedBox(
              width: 220,
              child: Text(
                LocalKeys.HOME_PANNAR.tr(),
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: HexColor('#d0011a')),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showMyOfferDialog({BuildContext context, String image}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              height: 300,
              width: 400,
              // padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: (apiLang() == 'en')
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                  ),
                  ListBody(
                    children: <Widget>[
                      Center(
                        child: Container(
                            height: 180,
                            width: 180,
                            child: Image.asset(
                              image,
                              fit: BoxFit.fitHeight,
                            )),
                      ),
                      spaceH(30),
                      SizedBox(
                        width: 100,
                        child: Text(
                          LocalKeys.HOME_PANNAR.tr(),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: HexColor('#d0011a')),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                LocalKeys.TURN_ON.tr(),
                style: GoogleFonts.roboto(
                    color: customColor, fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                _theMap();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
