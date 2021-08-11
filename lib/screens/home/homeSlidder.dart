import 'dart:async';
import 'package:konsolto/domain/brand_product/brand_product_repo.dart';
import 'package:konsolto/screens/pharmacy_category/pharmacy_category.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:konsolto/constants/constans.dart';

class HomeSlidder extends StatefulWidget {
  var homeSections;
  int thisIndex;
  HomeSlidder({Key key, this.homeSections, this.thisIndex}) : super(key: key);
  @override
  _HomeSlidderState createState() => _HomeSlidderState();
}

class _HomeSlidderState extends State<HomeSlidder> {
  int pageIndex = 0;
  int _currentPage = 0;
  static const _kDuration = const Duration(milliseconds: 1);
  static const _kCurve = Curves.ease;
  var isPageCanChanged = true;
  PageController _pageController = PageController();
  BrandsProductRepo brandsProductRepo = BrandsProductRepo();

  _mountSlider() {
    if (!mounted) return;
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      // return setState(() {
      if (_currentPage <
          widget.homeSections[widget.thisIndex]['sliders'].length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.easeIn,
      );
      // });
    });
  }

  @override
  void initState() {
    this._mountSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: PageView(
              controller: _pageController,
              allowImplicitScrolling: true,
              children: List<Widget>.generate(
                  widget.homeSections[widget.thisIndex]['sliders'].length,
                  (index) {
                return InkWell(
                  onTap: () {
                    print(widget.homeSections[widget.thisIndex]['sliders']
                        [index]['category']['_id']);

                    brandsProductRepo.getProductsbrand(
                        widget.homeSections[widget.thisIndex]['sliders'][index]
                            ['category']['_id']);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PharmacyCategoryPage(
                          id: widget.homeSections[widget.thisIndex]['sliders']
                              [index]['category']['_id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                      height: 200,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      child: customCachedNetworkImage(
                        context: context,
                        fit: BoxFit.cover,
                        url: widget.homeSections[widget.thisIndex]['sliders']
                            [index]['url'],
                      )),
                );
              }),
              onPageChanged: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
            ),
          ),
          spaceH(20),
          CarouselIndicator(
            color: customColorRed.withOpacity(.5),
            cornerRadius: 10,
            height: 10,
            width: 10,
            activeColor: customColorRed,
            count: widget.homeSections[widget.thisIndex]['sliders'].length,
            index: pageIndex,
          ),
        ],
      ),
    );
  }
}
