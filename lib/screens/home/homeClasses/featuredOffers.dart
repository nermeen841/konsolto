import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/screens/product_detail_screen/product_detail_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class Featuredoffers extends StatefulWidget {
  List<dynamic> homeSections;
  int thisIndex;
  Featuredoffers({Key key, this.homeSections, this.thisIndex})
      : super(key: key);

  @override
  _FeaturedoffersState createState() => _FeaturedoffersState();
}

class _FeaturedoffersState extends State<Featuredoffers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      // margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            LocalKeys.FEATURED_OFFER.tr(),
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 16,
            ),
          ),
          spaceH(10),
          Container(
            height: 266,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget.homeSections[widget.thisIndex]['products'].length,
              itemBuilder: (context, int index) {
                return Container(
                  width: 190,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => ProductdetailScreen(
                                    id: widget.homeSections[widget.thisIndex]
                                        ['products'][index]['_id'],
                                  )));
                    },
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (widget.homeSections[widget.thisIndex]['products']
                                      [index]['isOffer'] ==
                                  true)
                              ? Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: customColorRed,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Save 10 ' + LocalKeys.EGP.tr(),
                                      style: AppTheme.heading.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          spaceH(10),
                          Center(
                            child: Container(
                              height: 120,
                              width: 80,
                              child: customCachedNetworkImage(
                                context: context,
                                fit: BoxFit.fitHeight,
                                url: widget.homeSections[widget.thisIndex]
                                    ['products'][index]['url'],
                              ),
                            ),
                          ),
                          spaceH(10),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2,
                            ),
                            child: (apiLang() == 'en')
                                ? Text(
                                    (widget
                                                .homeSections[widget.thisIndex]
                                                    ['products'][index]
                                                    ['nameArabic']
                                                .length >
                                            25)
                                        ? widget.homeSections[widget.thisIndex]
                                                    ['products'][index]
                                                    ['nameArabic']
                                                .substring(0, 25) +
                                            "...."
                                        : widget.homeSections[widget.thisIndex]
                                            ['products'][index]['nameArabic'],
                                    style: AppTheme.subHeadingColorBlue
                                        .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    (widget
                                                .homeSections[widget.thisIndex]
                                                    ['products'][index]['name']
                                                .length >
                                            22)
                                        ? widget.homeSections[widget.thisIndex]
                                                    ['products'][index]['name']
                                                .substring(0, 22) +
                                            "...."
                                        : widget.homeSections[widget.thisIndex]
                                            ['products'][index]['name'],
                                    style: AppTheme.subHeadingColorBlue
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                  ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (widget.homeSections[widget.thisIndex]['products']
                                          [index]['oldPrice'] !=
                                      null)
                                  ? Text(
                                      widget.homeSections[widget.thisIndex]
                                                  ['products'][index]
                                                  ['oldPrice']
                                              .toString() +
                                          LocalKeys.EGP.tr(),
                                      style: AppTheme.subHeading
                                          .copyWith(fontSize: 14)
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    )
                                  : Container(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  widget.homeSections[widget.thisIndex]
                                              ['products'][index]['price']
                                          .toStringAsFixed(2) +
                                      LocalKeys.EGP.tr(),
                                  style: AppTheme.subHeading
                                      .copyWith(fontSize: 14)
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          spaceH(15),
                          Center(
                              child: CartData(
                            id: widget.homeSections[widget.thisIndex]
                                ['products'][index]['_id'],
                            name: widget.homeSections[widget.thisIndex]
                                ['products'][index]['name'],
                            url: widget.homeSections[widget.thisIndex]
                                ['products'][index]['url'],
                            oldprice: widget.homeSections[widget.thisIndex]
                                ['products'][index]['monthlyPrice'],
                            price: widget.homeSections[widget.thisIndex]
                                ['products'][index]['price'],
                            width2: 70.0,
                            width: 150.0,
                            inCart: false,
                          )),
                          spaceH(5),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
