import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/generated/local_keys.dart';

// ignore: must_be_immutable
class OrderusageButton extends StatefulWidget {
  List usageInstruction;
  OrderusageButton({Key key, @required this.usageInstruction})
      : super(key: key);
  @override
  _OrderusageButtonState createState() => _OrderusageButtonState();
}

class _OrderusageButtonState extends State<OrderusageButton> {
  @override
  Widget build(BuildContext context) {
    return (widget.usageInstruction.isEmpty)
        ? Container()
        : InkWell(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.bookMedical,
                    color: Colors.white,
                  ),
                  spaceW(5),
                  Text(
                    LocalKeys.ORDER_ISTRUCTION_BUTTON.tr(),
                    style: AppTheme.heading.copyWith(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              showSettingsPanel(
                context: context,
                child: Container(
                  height: 350,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.bookMedical,
                            color: Colors.red,
                          ),
                          spaceW(10),
                          Text(
                            LocalKeys.ORDER_ISTRUCTION_BUTTON.tr(),
                            style: AppTheme.heading.copyWith(
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      spaceH(15),
                      Container(
                          // height: 200,
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: true,
                            itemCount: widget.usageInstruction.length,
                            itemBuilder: (context, index) {
                              return Text(
                                widget.usageInstruction[index],
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            },
                          )),
                      spaceH(15),
                      _commen_button(),
                    ],
                  ),
                ),
              );
            },
          );
  }

  _commen_button() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: customColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            LocalKeys.DONE_BUTTON.tr(),
            style: AppTheme.heading.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
