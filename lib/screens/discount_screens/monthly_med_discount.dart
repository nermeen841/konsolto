import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/models/offersModels.dart';

class MonthlymedDiscountScreen extends StatefulWidget {
  @override
  _MonthlymedDiscountScreenState createState() =>
      _MonthlymedDiscountScreenState();
}

class _MonthlymedDiscountScreenState extends State<MonthlymedDiscountScreen> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.4,
          backgroundColor: Colors.white,
          title: Text(
            "Monthly Med Discounts",
            style: AppTheme.headingColorBlue.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: HexColor("#BB1D3C")),
          ),
        ),
        body: ListView(
            primary: true,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            children: [
              spaceH(10),
              Expanded(
                child: Text(
                  "Choose the choice med you use frequently to calculate your monthly cost after join Konsolto Chronic Med discount",
                  style: AppTheme.subHeadingColorBlue,
                ),
              ),
              spaceH(10),
              Card(
                elevation: 4,
                child: Container(
                  height: 30,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "what is your monthly med",
                      hintStyle: AppTheme.subHeadingColorBlue,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blue[200],
                      ),
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: 5,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (Context, index) {
                  return Container(
                      width: 180,
                      child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              child: Column(children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                // width: 120,
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
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: Container(
                            //       width: 50,
                            //       height: 50,
                            //       child: Image.network(
                            //           "${listOffers[index].title}")),
                            // ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listOffers[index].title,
                                        style: AppTheme.headingColorBlue
                                            .copyWith(color: Colors.red),
                                      ),
                                      Text(
                                        listOffers[index].subTitle,
                                        style: AppTheme.subHeading,
                                      ),
                                      spaceH(10),
                                      Row(
                                        children: [
                                          Text(
                                            '${listOffers[index].oldPrice} EGP',
                                            style: AppTheme.headingColorBlue
                                                .copyWith(
                                              color: customColorGray,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          spaceW(10),
                                          Text(
                                            '${listOffers[index].newPrice} EGP',
                                            style: AppTheme.subHeadingColorBlue,
                                          ),
                                        ],
                                      ),
                                      spaceH(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                bottom: 10, top: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: customColor2),
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                )),
                                            child: InkWell(
                                              child: Icon(
                                                Icons.remove,
                                                size: 20,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  counter--;
                                                  if (counter < 1) {
                                                    counter = 1;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Container(
                                              width: 70,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: customColor2),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(counter.toString()),
                                              )),
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: customColor2),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                              child: Center(
                                                child: InkWell(
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 20,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      counter++;
                                                    });
                                                  },
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]))));
                },
              ),
              spaceH(10),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Next(200 LE)",
                      style: AppTheme.heading.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
