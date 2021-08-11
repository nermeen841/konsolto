import 'package:flutter/material.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/domain/get_recommended/recommended_store.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/models/offersModels.dart';
import 'package:konsolto/screens/order_cart_tracking/mycart.dart';
import 'package:konsolto/screens/delivery_screens/check_out_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RecomendedproductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhenRebuilderOr<RecommendedStore>(
          initState: (context, rm) => rm.setState((s) => s.getRecommended()),
          observe: () => RM.get<RecommendedStore>(),
          builder: (context, model) => RecomendedproductScreen(),
          onWaiting: () => Loading(),
          onError: (error) =>
              IN.get<RecommendedStore>().getRecommended() == null
                  ? Text('$error')
                  : RecomendedproductScreen()),
    );
  }
}

class RecomendedproductScreen extends StatefulWidget {
  @override
  _RecomendedproductScreenState createState() =>
      _RecomendedproductScreenState();
}

class _RecomendedproductScreenState extends State<RecomendedproductScreen> {
  final recommendedModel = IN.get<RecommendedStore>().recommendedModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            LocalKeys.RECOMMENDED_LIST.tr(),
            style: AppTheme.headingColorBlue,
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              children: [
                Text(
                  LocalKeys.RECOMMENDED_TEXT.tr(),
                  style: AppTheme.headingColorBlue,
                ),
                spaceH(20),
                (recommendedModel.data.products.isNotEmpty)
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: listOffers.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ProductdetailPage(
                              //               id: listOffers[index].title,
                              //               )));
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 40,
                                        margin: EdgeInsets.only(left: 200),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                          ),
                                          color: customColorRed,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Save 10 LE',
                                            style: AppTheme.heading.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                listOffers[index].title,
                                                style:
                                                    AppTheme.headingColorBlue,
                                              ),
                                              Text(
                                                listOffers[index].subTitle,
                                                style: AppTheme.subHeading,
                                              ),
                                              spaceH(5),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${listOffers[index].oldPrice} EGP',
                                                    style: AppTheme
                                                        .headingColorBlue
                                                        .copyWith(
                                                      color: customColorGray,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  spaceW(5),
                                                  Text(
                                                    '${listOffers[index].newPrice} EGP',
                                                    style: AppTheme
                                                        .subHeadingColorBlue,
                                                  ),
                                                ],
                                              ),
                                              spaceH(5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.motorcycle,
                                                    color: Colors.yellow[900],
                                                  ),
                                                  spaceW(10),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      listOffers[index]
                                                          .delivery,
                                                      style: AppTheme.subHeading
                                                          .copyWith(
                                                        color: customColorRed,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              spaceH(10),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.motorcycle,
                                                    color: Colors.yellow[900],
                                                  ),
                                                  spaceW(10),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      listOffers[index].points,
                                                      style: AppTheme.subHeading
                                                          .copyWith(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              spaceH(10),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MycartPage(),
                                                      ));
                                                },
                                                child: Container(
                                                  width: 200,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: customColorGreen,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        LocalKeys.ADD_TO_CART
                                                            .tr(),
                                                        style: AppTheme.heading
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      spaceW(10),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .cartPlus,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              child: customCachedNetworkImage(
                                                context: context,
                                                url: listOffers[index].image,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.white,
                height: 120,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalKeys.TOTAL.tr(),
                          style: AppTheme.headingColorBlue.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(
                          "200 Egp",
                          style: AppTheme.subHeadingColorBlue,
                        ),
                      ],
                    ),
                    spaceH(10),
                    Center(
                      child: Text(
                        LocalKeys.MY_CART_MESS.tr(),
                        style: AppTheme.subHeading.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    spaceH(10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutDataScreen()));
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: customColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            LocalKeys.CHECK_OUT.tr(),
                            style:
                                AppTheme.heading.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
