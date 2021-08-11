import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/CameraScreens/scan_qr_code.dart';
import 'package:easy_localization/easy_localization.dart';

class QRCodeCard extends StatefulWidget {
  @override
  _QRCodeCardState createState() => _QRCodeCardState();
}

class _QRCodeCardState extends State<QRCodeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: ListView(
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          children: [
            emojiContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/images/excited.png"),
                  spaceH(20),
                  Text(
                    LocalKeys.SUCCESSQRSCAN.tr(),
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: HexColor('#F50900'),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                  spaceH(15),
                  Text(
                    LocalKeys.SUCCESSQRCODE.tr(),
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: HexColor("#080708"),
                        fontWeight: FontWeight.w400),
                  ),
                  Align(
                    alignment: (apiLang() == 'en')
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRViewScreen()));
                            },
                            child: Text(
                              LocalKeys.RESCANBUTTON.tr(),
                              style: GoogleFonts.roboto(
                                  color: HexColor('#00659A'),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              LocalKeys.OKTHANKSBUTTON.tr(),
                              style: GoogleFonts.roboto(
                                  color: HexColor('#00659A'),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            emojiContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/images/sad.png"),
                  spaceH(20),
                  Text(
                    LocalKeys.INVALIDCODE.tr(),
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: HexColor('#F50900'),
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                  Align(
                    alignment: (apiLang() == 'en')
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QRViewScreen()));
                        },
                        child: Text(
                          LocalKeys.RESCANBUTTON.tr(),
                          style: GoogleFonts.roboto(
                              color: HexColor('#00659A'),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ],
              ),
            ),
            emojiContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/images/sad.png"),
                  spaceH(20),
                  Text(
                    LocalKeys.USEDALLQRCODE.tr(),
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: HexColor('#F50900'),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                  Align(
                    alignment: (apiLang() == 'en')
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QRViewScreen()));
                        },
                        child: Text(
                          LocalKeys.RESCANBUTTON.tr(),
                          style: GoogleFonts.roboto(
                              color: HexColor('#00659A'),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ],
              ),
            ),
            emojiContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/images/angry.png"),
                  spaceH(20),
                  Text(
                    LocalKeys.HAVECODE.tr(),
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: HexColor('#F50900'),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                  Align(
                    alignment: (apiLang() == 'en')
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          LocalKeys.OKTHANKSBUTTON.tr(),
                          style: GoogleFonts.roboto(
                              color: HexColor('#00659A'),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  emojiContainer(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
