import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/models/user_data.dart';
import '../../sharedPreferences.dart';
import 'logIn/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  String userToken;
  String userFbToken;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  _getUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userToken = pref.getString('userToken');
      userFbToken = pref.getString('userFbToken');
    });
  }

  _getlocation() async {
    Userdata.lang = await MySharedPreferences.getUserlong() ?? "null";
    Userdata.let = await MySharedPreferences.getUserLat() ?? 'null';
  }

  @override
  void initState() {
    _getUserToken();
    _getlocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userToken == null) {
      return Container(
        child: LogIn(toggleView: toggleView),
      );
    } else {
      return SimplebottomNve();
    }
  }
}
