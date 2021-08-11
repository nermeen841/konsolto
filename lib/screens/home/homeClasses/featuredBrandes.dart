import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';

import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/home/homeClasses/all_brands_product.dart';

import 'package:konsolto/domain/brand_product/brand_product_repo.dart';
import 'package:easy_localization/easy_localization.dart';

class FeaturedBrandes extends StatefulWidget {
  List<dynamic> homeSections;
  int thisIndex;
  FeaturedBrandes({Key key, this.homeSections, this.thisIndex})
      : super(key: key);
  @override
  _FeaturedBrandesState createState() => _FeaturedBrandesState();
}

class _FeaturedBrandesState extends State<FeaturedBrandes> {
  BrandsProductRepo brandsProductRepo = BrandsProductRepo();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH(10),
          Text(
            LocalKeys.FEATURED_BRANDS.tr(),
            style: AppTheme.headingColorBlue.copyWith(fontSize: 18),
          ),
          spaceH(10),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.92,
              mainAxisSpacing: 0.6,
              crossAxisSpacing: 0.6,
            ),
            itemCount: widget.homeSections[widget.thisIndex]['brands'].length,
            semanticChildCount: 3,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  brandsProductRepo.getProductsbrand(widget
                      .homeSections[widget.thisIndex]['brands'][index]['_id']);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AllbrandProductsPage(
                            id: widget.homeSections[widget.thisIndex]['brands']
                                [index]['_id'],
                            name: widget.homeSections[widget.thisIndex]
                                ['brands'][index]['name'],
                          )));
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 5, left: 5),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: customCachedNetworkImage(
                        context: context,
                        url: widget.homeSections[widget.thisIndex]['brands']
                            [index]['url'],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
