import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';

class CustomSlider extends StatelessWidget {
  final String title, contant;
  final String image;
  final String backImage;
  CustomSlider({this.backImage, this.contant, this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 130),
        child: Column(
          children: [
            //   (apiLang() == 'en')
            //       ? Image.asset(
            //           'lib/images/new-konsolto-logo-05.png',
            //           width: 180,
            //           height: 45,
            //         )
            //       : Image.asset(
            //           'lib/images/new-konsolto-logo-04.png',
            //           width: 180,
            //           height: 45,
            //         ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(contant,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        color: customColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
