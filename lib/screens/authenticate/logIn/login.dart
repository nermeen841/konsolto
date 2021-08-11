import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/authenticate/logIn/confirmRegister.dart';


class LogIn extends StatefulWidget {
  final Function toggleView;
  LogIn({this.toggleView});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String phoneNamber;
  String password;
  String verificationId;
  String smsCode;
  String initval = '+2';
  Future<void> _verifyPhone() async {
    print('this phone is: ${this.phoneNamber}');
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verId) {
      this.verificationId = verId;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => 
          ConfirmPassword(
              userPhone: "+2" + this.phoneNamber,
              verificationId: this.verificationId),
        ),
      );
    };

    final PhoneCodeSent codeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ConfirmPassword(
              userPhone: "+2" + this.phoneNamber,
              verificationId: this.verificationId),
        ),
        
      );
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential user) {
      print('the user data is: ${user}');
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+2" + this.phoneNamber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                children: [
                  Center(
                      child: Container(
                          height: 100,
                          width: 200,
                          child: (apiLang() == 'en')
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    'lib/images/new-konsolto-logo-05.png',
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Container(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    'lib/images/new-konsolto-logo-04.png',
                                    fit: BoxFit.contain,
                                  ),
                                ))),
                  spaceH(40),
                  Text(
                    LocalKeys.LOG_IN_MESS.tr(),
                    style: AppTheme.subHeading,
                    textAlign: TextAlign.center,
                  ),
                  spaceH(30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          decoration: phoneFormInputDecoration(
                            hint: LocalKeys.MOBILE_NUMBER.tr(),
                            icon: Icons.phone,
                          ).copyWith(prefixText: "+2"),
                          validator: (value) => (value.length != 11)
                              ? "Phone formate not correct"
                              : null,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phoneNamber = value;
                          },
                        ),

                        spaceH(20),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () {
                            _formKey.currentState.validate();
                            _verifyPhone();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: customColor,
                          child: Text(
                            LocalKeys.NEXT.tr(),
                            style: AppTheme.headingColorBlue.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
