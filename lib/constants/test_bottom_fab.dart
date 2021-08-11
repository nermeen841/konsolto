import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:konsolto/network_sensitive.dart';
import 'package:konsolto/screens/CameraScreens/scan_qr_code.dart';
import 'package:konsolto/screens/home/homeClasses/tapToSeeOffers.dart';
import 'package:konsolto/screens/home/silverappbar_test.dart';
import 'package:konsolto/screens/timeline/TimeLine.dart';
import 'package:konsolto/screens/wrapper/new_more.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plain_notification_token/plain_notification_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sharedPreferences.dart';

class SimplebottomNve extends StatelessWidget {
  final thisUserData;
  SimplebottomNve({Key key, this.thisUserData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkSensitive(
        child: SimplebottomNvepage(
          thisUserData: thisUserData,
        ),
      ),
    );
  }
}

class SimplebottomNvepage extends StatefulWidget {
  final thisUserData;
  SimplebottomNvepage({Key key, this.thisUserData}) : super(key: key);
  @override
  _SimplebottomNvepageState createState() => _SimplebottomNvepageState();
}

class _SimplebottomNvepageState extends State<SimplebottomNvepage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  // ignore: unused_field
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  String cartTotal;
  String cartItems;
  Widget icon = Icon(
    Icons.camera_alt,
    color: Colors.white,
  );

  final plainNotificationToken = PlainNotificationToken();
  _theMap() async {
    await Geolocator.getCurrentPosition().then((value) {
      MySharedPreferences.saveUserlong(value.longitude.toString());
      MySharedPreferences.saveUserlat(value.latitude.toString());
      TapToSeeOffers.currentPosition = value;
    });
  }

  _getLocation() async {
    Userdata.lang = await MySharedPreferences.getUserlong() ?? "null";
    Userdata.let = await MySharedPreferences.getUserLat() ?? 'null';
    Userdata.asddres = await MySharedPreferences.getUserAddress() ?? 'null';
    Userdata.appLang = await MySharedPreferences.getAppLang() ?? 'en';
  }

  _postnotificationToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final _token = preferences.getString('userToken');
    if (Platform.isIOS) {
      plainNotificationToken.requestPermission();
      await plainNotificationToken.onIosSettingsRegistered.first;
    }
    // ignore: non_constant_identifier_names
    final firebase_token = await plainNotificationToken.getToken();
    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $_token',
      };

      Map<String, String> _body = {"token": firebase_token};

      var response = await http.post(
          Uri.parse("https://sprint.konsolto.com/patients/addfirebasetoken"),
          headers: requestHeaders,
          body: _body);
      var _data = json.decode(response.body);
      if (_data['success'] == true) {
        print(
            "------------------------------------- NOTIFIVATION TOKEN SUCCESS");
      }
    } catch (e) {
      // ignore: unnecessary_brace_in_string_interps
      print('${e}');
    }
  }

  @override
  void initState() {
    if (Userdata.lang == "null" && Userdata.let == "null") {
      _theMap();
    }
    _getLocation();
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 500))
          ..addListener(() {
            setState(() {
              icon = Icon(
                Icons.clear,
                color: Colors.white,
              );
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                icon = Icon(
                  Icons.clear,
                  color: Colors.white,
                );
              });
            } else if (status == AnimationStatus.dismissed) {
              setState(() {
                icon = Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                );
              });
            }
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor =
        ColorTween(begin: HexColor('#d0011a'), end: HexColor('#d0011a'))
            .animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 0.75, curve: _curve)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buttonCamera() {
    if (isOpened) {
      return InkWell(
        onTap: () {
          _loadPicker(context);
          animate();
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.8),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              spaceW(5),
              Text(
                LocalKeys.PHOTO_RX.tr(),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      );
    }
    return Container();
  }

  _loadPicker(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile picked = await imagePicker.getImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        // _imageFile = File(picked.path);
        // final bytes = _imageFile.readAsBytesSync();
        // _imagelist.add(_imageFile);
        // _imagebase64.add(bytes.toString());
      });
    }
    Navigator.of(context).pop();
  }

  Widget buttonQR() {
    if (isOpened) {
      return InkWell(
          onTap: () {
            animate();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => QRViewScreen()));
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.8),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner_outlined,
                  color: Colors.white,
                ),
                spaceW(5),
                Text(
                  LocalKeys.SCAN_QR.tr(),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ));
    }
    return Container();
  }

  Widget buttonToggle() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: _buttonColor.value,
          onPressed: animate,
          tooltip: "Toggle",
          child: icon),
    );
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  final List<Widget> _children = [
    SilverTest(),
    Text('page3'),
    TimeLine(),
    NewMorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Freshchat.init("9a2af457-03fc-4bc6-b1ad-e1567eae845f",
        "2411e1a6-b657-4fa4-9ee9-55316087d1cc", "http://msdk.freshchat.com");

    this._postnotificationToken();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
              transform: Matrix4.translationValues(
                  0.0, _translateButton.value * 1.5, 0.0),
              child: buttonCamera()),
          Transform(
              transform:
                  Matrix4.translationValues(0.0, _translateButton.value, 0.0),
              child: buttonQR()),
          buttonToggle()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                      if (isOpened) {
                        animate();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .20,
                      padding: EdgeInsets.only(top: 5),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "lib/images/pills.png",
                            color: (_currentIndex == 0)
                                ? customColor
                                : Colors.grey[300],
                            width: 20,
                            height: 20,
                          ),
                          Text(
                            LocalKeys.PHARMACY_NAV.tr(),
                            style: TextStyle(
                                color: (_currentIndex == 0)
                                    ? customColor
                                    : Colors.grey[300],
                                fontSize: 14),
                          )
                        ],
                      ),
                    )),

                InkWell(
                    child: Container(
                  width: MediaQuery.of(context).size.width * .20,
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => Freshchat.showConversations(),
                        child: Icon(FontAwesomeIcons.comments,
                            color: Colors.grey[300], size: 20),
                      ),
                      Text(
                        LocalKeys.PHARMACIEST.tr(),
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .20,
                ), // The dummy child

                InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                      if (isOpened) {
                        animate();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .20,
                      padding: EdgeInsets.only(top: 5),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "lib/images/timelineLine.png",
                            color: (_currentIndex == 2)
                                ? customColor
                                : Colors.grey[300],
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            LocalKeys.TIME_LINE_NAV.tr(),
                            style: TextStyle(
                                color: (_currentIndex == 2)
                                    ? customColor
                                    : Colors.grey[300]),
                          )
                        ],
                      ),
                    )),

                InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                      if (isOpened) {
                        animate();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .20,
                      padding: EdgeInsets.only(top: 5),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.more_horiz,
                              color: (_currentIndex == 3)
                                  ? customColor
                                  : Colors.grey[300],
                              size: 20),
                          Text(
                            LocalKeys.MORE.tr(),
                            style: TextStyle(
                                color: (_currentIndex == 3)
                                    ? customColor
                                    : Colors.grey[300]),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          )),
      body: _children[_currentIndex],
    );
  }
}
