import 'package:flutter/material.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:easy_localization/easy_localization.dart';

class PharmacydeliveryNote extends StatefulWidget {
  String data;
  String note;
  String pharmacyMsg;
  PharmacydeliveryNote(
      {Key key,
      @required this.data,
      @required this.note,
      @required this.pharmacyMsg})
      : super(key: key);
  @override
  _PharmacydeliveryNoteState createState() => _PharmacydeliveryNoteState();
}

class _PharmacydeliveryNoteState extends State<PharmacydeliveryNote> {
  @override
  Widget build(BuildContext context) {
    return (widget.data == null)
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.circle,
                      color: Colors.black,
                      size: 20,
                    ),
                    spaceW(5),
                    Text(
                      widget.data.toString(),
                      style: AppTheme.heading,
                    ),
                  ],
                ),
                spaceH(10),
                (widget.note == null)
                    ? Container()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalKeys.DELIVERY_NOTE.tr() + " :",
                            style: AppTheme.subHeadingColorBlue,
                          ),
                          spaceW(5),
                          Text(
                            widget.note.toString(),
                            style: AppTheme.subHeading,
                          ),
                        ],
                      ),
                spaceH(10),
                (widget.pharmacyMsg == null)
                    ? Container()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalKeys.PHARMACY_NOTE.tr() + " :",
                            style: AppTheme.subHeadingColorBlue,
                          ),
                          spaceW(5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              widget.pharmacyMsg.toString(),
                              style: AppTheme.subHeading,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
  }
}
