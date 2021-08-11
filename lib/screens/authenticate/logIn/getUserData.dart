import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:konsolto/screens/authenticate/logIn/confirmRegister.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class GitUserDate extends StatefulWidget {
  String theFinalToken;
  String theDBToken;
  String theUserID;
  bool isProfileComplete = false;

  GitUserDate(
      {Key key,
      this.theFinalToken,
      this.theDBToken,
      this.isProfileComplete,
      this.theUserID})
      : super(key: key);
  @override
  _GitUserDateState createState() => _GitUserDateState();
}

class _GitUserDateState extends State<GitUserDate> {
  int id;
  String _chossenDate;
  String _lang;
  String _gender;
  String _name;
  String uId;

  TextEditingController _nameController;

  _checkForUserConfirmed() async {
    if (widget.isProfileComplete != false) {
      RM.navigate.to(SimplebottomNve());
    }
    if (widget.theUserID == null) {
      RM.navigate.to(ConfirmPassword());
    }
  }

  _editProfileData() async {
    if (widget.theFinalToken != null) {
      try {
        Map<String, String> requestHeaders = {
          'Authorization': 'Bearer ${widget.theDBToken}',
          'Content-Type': 'application/json',
        };
        print('=======================${_name}');
        var response = await http.put(
            Uri.parse(Utils.EDITPROFILE_URL + '/' + widget.theUserID),
            headers: requestHeaders,
            body: jsonEncode(<String, String>{
              "gender": _gender,
              "language": apiLang(),
              "birthDate": _chossenDate,
              "name": _name
            }));
        var thisDetails = json.decode(response.body);
        print(thisDetails);
        if (thisDetails != null) {
          if (thisDetails['success'] != false) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SimplebottomNve(),
              ),
              (routes) => false,
            );
          }
        }
        // for (var singleProduct in thisDetails['data']['cart']['details']) {
        //   if (singleProduct['product']['_id'] == widget.id) {
        //     SharedPreferences pref = await SharedPreferences.getInstance();
        //     setState(() {
        //       pref.setBool('hasCart', true);
        //       bool hasCart = pref.getBool('hasCart');
        //       this._visible = false;
        //       this._visible2 = true;
        //       this.counter = singleProduct['quantity'];
        //     });
        //   }
        // }
      } catch (e) {
        print('${e}');
      }
    }
  }

  @override
  void initState() {
    this._checkForUserConfirmed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Form(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            Center(
              child: Container(
                  height: 100,
                  width: 200,
                  child: (Userdata.appLang == 'en')
                      ? Image.asset(
                          'lib/images/new-konsolto-logo-04.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          'lib/images/new-konsolto-logo-05.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        )),
            ),
            spaceH(30),
            Text(
              LocalKeys.THANKS_FOR.tr(),
              style: AppTheme.heading.copyWith(
                fontSize: 12,
              ),
            ),
            spaceH(20),
            Container(
              height: 50,
              color: Colors.white,
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _name = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: LocalKeys.TYPE_YOUR_NAME.tr(),
                  hintStyle: AppTheme.heading.copyWith(
                    fontSize: 14,
                  ),
                  labelStyle: AppTheme.heading.copyWith(
                    fontSize: 14,
                  ),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            spaceH(20),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: new DateTime(1900),
                  onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  },
                  onConfirm: (date) {
                    setState(() {
                      _chossenDate = "${date.month}/${date.day}/${date.year}";
                      // Age.resAge = _chossenDate;
                    });
                    print('confirm $date');
                  },
                  currentTime: DateTime.now(),
                );
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: customColorGray,
                    width: 1,
                  ),
                ),
                child: Text(
                  (_chossenDate) ?? LocalKeys.DATE_OF_BIRTH.tr(),
                  style: AppTheme.heading.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            spaceH(20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(LocalKeys.GENDER.tr(),
                      style: AppTheme.heading.copyWith(fontSize: 11)),
                ),
                Expanded(
                  flex: 3,
                  child: RadioListTile(
                    title: Text(
                      LocalKeys.MALE.tr(),
                      style: AppTheme.heading.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    groupValue: _gender,
                    value: LocalKeys.MALE.tr(),
                    onChanged: (val) {
                      setState(() {
                        _gender = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: RadioListTile(
                    activeColor: Colors.red,
                    title: Text(
                      LocalKeys.FEMALE.tr(),
                      style: AppTheme.heading.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    groupValue: _gender,
                    value: LocalKeys.FEMALE.tr(),
                    onChanged: (val) {
                      setState(() {
                        _gender = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [],
            ),
            spaceH(20),
            Container(
              height: 50,
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: AppTheme.heading.copyWith(
                    fontSize: 14,
                  ),
                  fillColor: Colors.white,
                  labelText: LocalKeys.REFERRAL_CODE.tr(),
                  labelStyle: AppTheme.heading.copyWith(
                    fontSize: 14,
                  ),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            spaceH(40),
            Center(
              child: Text(
                LocalKeys.BY_CLICKING.tr(),
                style: AppTheme.heading.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
            spaceH(10),
            Center(
              child: InkWell(
                onTap: () {},
                child: Text(
                  LocalKeys.PRIVACY_POLICY.tr(),
                  style: AppTheme.headingColorBlue.copyWith(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            spaceH(20),
            Center(
              child: CustomButton(
                text: LocalKeys.SUBMIT.tr(),
                onPress: () {
                  _editProfileData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
