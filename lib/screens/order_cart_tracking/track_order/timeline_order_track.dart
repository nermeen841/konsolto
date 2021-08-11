import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class TimelineOrderTrack extends StatefulWidget {
  String orderStatuse;
  TimelineOrderTrack({Key key, @required this.orderStatuse}) : super(key: key);
  @override
  _TimelineOrderTrackState createState() => _TimelineOrderTrackState();
}

class _TimelineOrderTrackState extends State<TimelineOrderTrack> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "lib/images/motorCycleIcon.png",
                  width: 20,
                  height: 20,
                ),
                spaceW(10),
                SizedBox(
                  width: 285,
                  child: Text(LocalKeys.DELIVER_TIMELINE_NOTE.tr(),
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w400))),
                ),
              ],
            ),
            spaceH(10),
            Expanded(
              child: Row(
                children: [
                  (apiLang() == 'en')
                      ? Expanded(
                          child: TimelineTile(
                            isLast: true,
                            alignment: TimelineAlign.start,
                            axis: TimelineAxis.horizontal,
                            lineXY: .3,
                            afterLineStyle: LineStyle(color: Colors.grey[100]),
                            indicatorStyle: IndicatorStyle(
                              width: 30,
                              height: 30,
                              indicator: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100],
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 30,
                                  color: (widget.orderStatuse == "Requested" ||
                                          widget.orderStatuse == "OnTheWay" ||
                                          widget.orderStatuse == "Delivered")
                                      ? customColorGreen
                                      : Colors.grey[100],
                                ),
                              ),
                              color: Colors.white,
                            ),
                            endChild: Text(
                              "${LocalKeys.TIMELINEPLACED.tr()}",
                              style: AppTheme.subHeadingColorBlue,
                            ),
                            hasIndicator: true,
                          ),
                        )
                      : Expanded(
                          child: TimelineTile(
                            isFirst: true,
                            alignment: TimelineAlign.start,
                            axis: TimelineAxis.horizontal,
                            lineXY: .3,
                            afterLineStyle: LineStyle(color: Colors.grey[100]),
                            indicatorStyle: IndicatorStyle(
                              width: 30,
                              height: 30,
                              indicator: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100],
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 30,
                                  color: (widget.orderStatuse == "Requested" ||
                                          widget.orderStatuse == "OnTheWay" ||
                                          widget.orderStatuse == "Delivered")
                                      ? customColorGreen
                                      : Colors.grey[100],
                                ),
                              ),
                              color: Colors.white,
                            ),
                            endChild: Text(
                              "${LocalKeys.TIMELINEPLACED.tr()}",
                              style: AppTheme.subHeadingColorBlue,
                            ),
                            hasIndicator: true,
                          ),
                        ),
                  Expanded(
                    child: TimelineTile(
                      alignment: TimelineAlign.start,
                      axis: TimelineAxis.horizontal,
                      lineXY: .3,
                      beforeLineStyle: LineStyle(color: Colors.grey[100]),
                      afterLineStyle: LineStyle(color: Colors.grey[100]),
                      indicatorStyle: IndicatorStyle(
                        width: 30,
                        height: 30,
                        indicator: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: customColorGray,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              size: 30,
                              color: (widget.orderStatuse == "OnTheWay" ||
                                      widget.orderStatuse == "Delivered")
                                  ? customColorGreen
                                  : Colors.grey[100],
                            )),
                        color: Colors.white,
                      ),
                      endChild: (widget.orderStatuse == "OnTheWay" ||
                              widget.orderStatuse == "Delivered")
                          ? Text(
                              "${LocalKeys.TIMELINEONTHEWAY.tr()}",
                              style: AppTheme.subHeadingColorBlue,
                            )
                          : Text(""),
                      hasIndicator: true,
                    ),
                  ),
                  (apiLang() == 'en')
                      ? Expanded(
                          child: TimelineTile(
                            isFirst: true,
                            alignment: TimelineAlign.start,
                            axis: TimelineAxis.horizontal,
                            lineXY: .3,
                            beforeLineStyle: LineStyle(color: Colors.grey[100]),
                            indicatorStyle: IndicatorStyle(
                              width: 30,
                              height: 30,
                              indicator: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100],
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 30,
                                  color: (widget.orderStatuse == "Delivered")
                                      ? customColorGreen
                                      : Colors.grey[100],
                                ),
                              ),
                              color: Colors.white,
                            ),
                            endChild: (widget.orderStatuse == "Delivered")
                                ? Text(
                                    "${LocalKeys.TIMELINEDELIVERED.tr()}",
                                    style: AppTheme.subHeadingColorBlue,
                                  )
                                : Text(""),
                            hasIndicator: true,
                          ),
                        )
                      : Expanded(
                          child: TimelineTile(
                            isLast: true,
                            alignment: TimelineAlign.start,
                            axis: TimelineAxis.horizontal,
                            lineXY: .3,
                            beforeLineStyle: LineStyle(color: Colors.grey[100]),
                            indicatorStyle: IndicatorStyle(
                              width: 30,
                              height: 30,
                              indicator: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100],
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 30,
                                  color: (widget.orderStatuse == "Delivered")
                                      ? customColorGreen
                                      : Colors.grey[100],
                                ),
                              ),
                              color: Colors.white,
                            ),
                            endChild: (widget.orderStatuse == "Delivered")
                                ? Text(
                                    "${LocalKeys.TIMELINEDELIVERED.tr()}",
                                    style: AppTheme.subHeadingColorBlue,
                                  )
                                : Text(""),
                            hasIndicator: true,
                          ),
                        ),
                ],
              ),
            )
          ],
        ));
  }
}
