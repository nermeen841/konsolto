import 'package:flutter/material.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/generated/local_keys.dart';

class CancelledSademoji extends StatefulWidget {
  @override
  _CancelledSademojiState createState() => _CancelledSademojiState();
}

class _CancelledSademojiState extends State<CancelledSademoji> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("lib/images/sad.png"),
          ),
          spaceH(10),
          Center(
            child: Text(
              "${LocalKeys.CANCELLED.tr()}",
              style: AppTheme.headingColorBlue.copyWith(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
