import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';

class SeaconalSelection extends StatefulWidget {
  Map<String, dynamic> homeSections;
  int thisIndex;
  SeaconalSelection({Key key, this.homeSections, this.thisIndex}) : super(key: key);
  @override
  _SeaconalSelectionState createState() => _SeaconalSelectionState();
}

class _SeaconalSelectionState extends State<SeaconalSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      color: customColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seaconal Selection',
            style: AppTheme.heading.copyWith(
              fontSize: 16,
              color: Color(0xfff0c1f4f),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 150,
                child: Card(
                  elevation: 4,
                  color: customColorGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Ramadan Kareem',
                          style: TextStyle(color: Colors.black,fontSize:12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150,
                  child: GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    childAspectRatio: 1.55,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: List.generate(
                      4,
                      (index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (_) => CategoriesCoursesPage(
                            //       categories: categoriesList[index],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            child: Card(
                              elevation: 4,
                              color: customColorGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'Ramadan Kareem',
                                      style: TextStyle(color: Colors.black,fontSize:12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
