import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/screens/authenticate/logIn/getUserData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class ConfirmPassword extends StatefulWidget {
  String userPhone;
  String verificationId;
  static bool isButtonDisabled = false;
  ConfirmPassword({Key key, this.userPhone, this.verificationId})
      : super(key: key);

  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final int codeLength = 6;
  int timer;
  int _otpCodeLength = 6;
  // String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String smsCode;
  bool hasError = false;
  String currentText = "";
  StreamController<ErrorAnimationType> errorController;
  TextEditingController textEditingController = TextEditingController();

  String validateCode(String code) {
    if (code.length < codeLength)
      return "please write the full code";
    else {
      bool isNumeric = int.tryParse(code) != null;
      if (!isNumeric) return "your code must be in numbers";
    }
    return null;
  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      ConfirmPassword.isButtonDisabled = !ConfirmPassword.isButtonDisabled;
      _verifyOtpCode();
      this.signIn();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this.smsCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        setState(() {
          ConfirmPassword.isButtonDisabled = true;
        });

        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        setState(() {
          ConfirmPassword.isButtonDisabled = true;
        });
        this.signIn();
      } else {
        ConfirmPassword.isButtonDisabled = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    this.signIn();
    setState(() {
      ConfirmPassword.isButtonDisabled = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
  }

  @override
  Widget build(BuildContext context) {
    print('-----------------------------------------------------' +
        widget.verificationId);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: ListView(
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      height: 100,
                      width: 200,
                      child: (apiLang() == 'en')
                          ? Image.asset(
                              'lib/images/new-konsolto-logo-05.png',
                            )
                          : Image.asset(
                              'lib/images/new-konsolto-logo-04.png',
                            )),
                ),
                spaceH(30),
                Center(
                  child: Text(
                    LocalKeys.CONFIRM_MESS.tr(),
                    textAlign: TextAlign.center,
                    style: AppTheme.subHeading.copyWith(),
                  ),
                ),
                spaceH(30),
                Center(
                  child: 
                      TextFieldPin(
                    filled: true,
                    filledColor: Colors.white,
                    codeLength: _otpCodeLength,
                    boxSize: 40,
                    filledAfterTextChange: true,
                    textStyle: TextStyle(fontSize: 16),
                    borderStyle: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    onOtpCallback: (code, isAutofill) =>
                        _onOtpCallBack(code, isAutofill),
                  )
                  // PinCodeTextField(
                  //   enablePinAutofill: true,
                  //   mainAxisAlignment: MainAxisAlignment.values[5],
                  //   appContext: context,
                  //   pastedTextStyle: TextStyle(
                  //     color: Colors.blue,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   length: 6,
                  //   obscureText: false,
                  //   animationType: AnimationType.fade,
                  //   pinTheme: PinTheme(
                  //     inactiveFillColor: Colors.white,
                  //     activeFillColor: Colors.white,
                  //     selectedColor: Colors.white,
                  //     selectedFillColor: Colors.white,
                  //     inactiveColor: Colors.white,
                  //     activeColor: Colors.white,
                  //     borderWidth: 0,
                  //     shape: PinCodeFieldShape.box,
                  //     fieldHeight: 50,
                  //     fieldWidth: 40,
                  //   ),
                  //   cursorColor: Colors.black,
                  //   animationDuration: Duration(milliseconds: 300),
                  //   enableActiveFill: true,
                  //   errorAnimationController: errorController,
                  //   controller: textEditingController,
                  //   keyboardType: TextInputType.number,
                  //   onCompleted: (v) {
                  //     print("Completed");
                  //     setState(() {
                  //       this.smsCode = v;
                  //       ConfirmPassword.isButtonDisabled = true;
                  //     });
                  //     signIn();
                  //   },
                  //   onChanged: (value) {
                  //     print(value);
                  //     setState(() {
                  //       this.smsCode = value;
                  //     });
                  //   },
                  //   beforeTextPaste: (text) {
                  //     print("Allowing to paste $text");
                  //     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //     //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  //     return true;
                  //   },
                  // ),

                ),
                spaceH(20),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(10),
                    color: customColor,
                    child: MaterialButton(
                      onPressed: ConfirmPassword.isButtonDisabled
                          ? () {
                              print(smsCode);
                              if (smsCode != null) {
                                signIn();
                              }
                            }
                          : null,
                      minWidth: 150,
                      height: 48,
                      child: Text(
                        ConfirmPassword.isButtonDisabled
                            ? "Hold on..."
                            : LocalKeys.RESEND_CODE.tr(),
                        style: AppTheme.heading.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );

    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user =
        await _auth.signInWithCredential(credential).then((user) async {
      final theFinalToken = await user.getIdToken();
      print('________________this user FB data is: ${theFinalToken}');
      if (theFinalToken != null) {
        Map<String, String> _body = {'token': theFinalToken};
        var response =
            await http.post(Uri.parse(Utils.LOGINWITHFB_URL), body: _body);
        var thisDetails = json.decode(response.body);
        print(
            ' --------------------------------- details here is: ${thisDetails}');
        // print(
        //     ' --------------------------------- FB token here is: ${theFinalToken}');
        if (thisDetails != null) {
          if (thisDetails['success'] == true) {
            SharedPreferences _sp = await SharedPreferences.getInstance();
            _sp.setString('userToken', thisDetails['data']['token']);
            _sp.setString('userDbId', thisDetails['data']['patient']['_id']);
            if (thisDetails['data']['isProfileComplete'] == false) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => GitUserDate(
                      theFinalToken: theFinalToken,
                      theDBToken: thisDetails['data']['token'],
                      theUserID: thisDetails['data']['patient']['_id'],
                      isProfileComplete: false),
                ),
                (routes) => false,
              );
            }
            if (thisDetails['data']['isProfileComplete'] != false) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => SimplebottomNve(
                      thisUserData: thisDetails['data']['patient']),
                ),
                (routes) => false,
              );
            }
          }
        }
      }
    }).catchError((e) {
      print(e);
    });
  }
}
