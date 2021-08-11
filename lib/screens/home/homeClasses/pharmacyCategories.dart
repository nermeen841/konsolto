import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/domain/single_category_data/single_cat_repo.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/pharmacy_category/pharmacy_category.dart';

class PharmacyCategaorises extends StatefulWidget {
  List<dynamic> homeSections;
  int thisIndex;
  PharmacyCategaorises({Key key, this.homeSections, this.thisIndex})
      : super(key: key);
  @override
  _PharmacyCategaorisesState createState() => _PharmacyCategaorisesState();
}

class _PharmacyCategaorisesState extends State<PharmacyCategaorises> {
  SinglecatRepo singlecatRepo = SinglecatRepo();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.PHARMACY_CATEGORIES.tr(),
            style: AppTheme.headingColorBlue
                .copyWith(fontSize: 16, color: HexColor('#d0011a')),
          ),
          spaceH(10),
          GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount:
                widget.homeSections[widget.thisIndex]['categories'].length,
            semanticChildCount: 3,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  singlecatRepo.getSingleCat(
                      widget.homeSections[widget.thisIndex]['categories'][index]
                          ['_id']);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PharmacyCategoryPage(
                            id: widget.homeSections[widget.thisIndex]
                                ['categories'][index]['_id'],
                          )));
                },
                child: Container(
                  height: 80,
                  width: 107,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              widget.homeSections[widget.thisIndex]
                                  ['categories'][index]['url']),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Image.network(
                      //   homeSectionModel
                      //       .data.sections[2].categories[index].url,
                      //   fit: BoxFit.cover,
                      // ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              (apiLang() == 'en')
                                  ? widget.homeSections[widget.thisIndex]
                                      ['categories'][index]['aname']
                                  : widget.homeSections[widget.thisIndex]
                                      ['categories'][index]['name'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  // shadows: <Shadow>[
                                  //   Shadow(
                                  //     offset: Offset(1.0, 1.0),
                                  //     blurRadius: 3.0,
                                  //     color: Color.fromARGB(225, 0, 0, 0),
                                  //   ),
                                  //   Shadow(
                                  //     offset: Offset(1.0, 1.0),
                                  //     blurRadius: 8.0,
                                  //     color: Color.fromARGB(125, 0, 0, 0),
                                  //   ),
                                  // ],
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
