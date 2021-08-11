import 'package:flutter/material.dart';
import 'package:konsolto/screens/authenticate/logIn/confirmRegister.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class CodeVerification extends StatefulWidget {
  @override
  _CodeVerificationState createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";


  @override
  void initState() {
    super.initState();
    _getSignatureCode();
  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        setState(() {
          ConfirmPassword.isButtonDisabled = true;
        });
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        setState(() {
          ConfirmPassword.isButtonDisabled = true;
        });
      } else {
        ConfirmPassword.isButtonDisabled = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldPin(
      filled: true,
      filledColor: Colors.white,
      codeLength: _otpCodeLength,
      boxSize: 40,
      filledAfterTextChange: true,
      textStyle: TextStyle(fontSize: 16),
      borderStyle: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      onOtpCallback: (code, isAutofill) => _onOtpCallBack(code, isAutofill),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:pin_input_text_field/pin_input_text_field.dart';

// class Registration extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(title: Text("Auto SMS Read"),
//         backgroundColor: Colors.purple,),
//       body: Center(
//         child: Container(
//           // ignore: deprecated_member_use
//           child: RaisedButton(
//             onPressed: () async {
//               final signature=await SmsAutoFill().getAppSignature;
//               print(signature);
//               Navigator.push(context, MaterialPageRoute(builder: (context){
//                 return OTP();
//               }));
//             },
//             color: Colors.purple,
//             child: Text("Registration/Login",  style: TextStyle(fontSize: 20, color: Colors.white)),

//           ),
//         ),
//       ),
//     );
//   }

// }

// class OTP extends StatefulWidget {
//   @override
//   _OTPState createState() => _OTPState();
// }

// class _OTPState extends State<OTP> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _listOPT();
//   }
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(title: Text("Auto SMS Read"),
//         backgroundColor: Colors.purple,),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Enter PIN"),
//               Container(
//                 child:  PinFieldAutoFill(

//                   decoration: BoxTightDecoration(
//                     textStyle: TextStyle(fontSize: 20, color: Colors.black),
//                     strokeColor : Colors.black.withOpacity(0.3),
//                   ),
//                  codeLength: 6,
//                   onCodeSubmitted: (code) {},
//                   onCodeChanged: (code) {
//                     if (code.length == 6) {
//                       FocusScope.of(context).requestFocus(FocusNode());
//                     }
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _listOPT()
//   async {
//     await SmsAutoFill().listenForCode;
//   }
// }
