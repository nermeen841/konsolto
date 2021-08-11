import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/models/homeSearchApi.dart';
import 'package:konsolto/screens/product_detail_screen/product_detail_screen.dart';

class HomeSearch extends SearchDelegate {
  HomeSearch()
      : super(
          searchFieldStyle: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, color: customColor),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldLabel: LocalKeys.SEARCH_MESS_HINT.tr(),
        );
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      InkWell(
        child: Icon(Icons.clear),
        onTap: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.search,
        color: Colors.black,
      ),
      onTap: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: HomeSearchApi.homeSearch(query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(LocalKeys.SEARCH_MESS_HINT.tr()),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        primary: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductdetailScreen(
                                    id: snapshot.data[index].sId,
                                  ),
                                ),
                              );
                            },
                            child: prodectCard(snapshot, index, context),
                          );
                        },
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
  }

  Card prodectCard(AsyncSnapshot snapshot, int index, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .65,
                        child: Text(
                          snapshot.data[index].name,
                          style: AppTheme.headingColorBlue,
                        ),
                      ),
                      Text(
                        snapshot.data[index].formQuantity.toString(),
                        style: AppTheme.subHeading,
                      ),
                      spaceH(10),
                      Row(
                        children: [
                          (snapshot.data[index].oldPrice.toString() == '0')
                              ? Container()
                              : Text(
                                  snapshot.data[index].oldPrice
                                          .toStringAsFixed(2) +
                                      LocalKeys.EGP.tr(),
                                  style: AppTheme.subHeading.copyWith(
                                      decoration: TextDecoration.lineThrough),
                                ),
                          spaceW(10),
                          Text(snapshot.data[index].price + LocalKeys.EGP.tr(),
                              style: AppTheme.subHeadingColorBlue),
                        ],
                      ),
                      spaceH(10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: CartData(
                          id: snapshot.data[index].sId,
                          name: snapshot.data[index].name ?? "",
                          price: snapshot.data[index].price ?? '',
                          url: snapshot.data[index].url,
                          width: 150.0,
                          width2: 70.0,
                          inCart: false,
                        ),
                      )
                    ],
                  ),
                  spaceW(20),
                  Expanded(
                    child: Container(
                      width: 50,
                      height: 80,
                      child: customCachedNetworkImage(
                        context: context,
                        fit: BoxFit.contain,
                        url: snapshot.data[index].url,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: HomeSearchApi.homeSearch(query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(LocalKeys.SEARCH_MESS_HINT.tr()),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductdetailScreen(
                                    id: snapshot.data[index].sId,
                                  ),
                                ),
                              );
                            },
                            child: prodectCard(snapshot, index, context),
                          );
                        },
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
  }
}
