import 'dart:async';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';


class ProductdetailSwiper extends StatefulWidget {
  @override
  _ProductdetailSwiperState createState() => _ProductdetailSwiperState();
}

class _ProductdetailSwiperState extends State<ProductdetailSwiper> {


  int pageIndex = 0;

  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      return setState(() {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    });
  }
  
  
  
  @override
  Widget build(BuildContext context) {

    List<Widget> _demo = [
     Image.asset("lib/images/logo icon.png", fit: BoxFit.cover,),
      Image.asset("lib/images/logo icon.png", fit: BoxFit.cover,),
      Image.asset("lib/images/logo icon.png", fit: BoxFit.cover,)
    ];



    return Container(
      margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: PageView(
              controller: _pageController,
              allowImplicitScrolling: true,
              children: _demo,

              onPageChanged: (index){
                setState(() {
                  pageIndex=index;
                });
              },
            ),
          ),
//          CarouselSlider(
//            options: CarouselOptions(
//              autoPlayInterval: Duration(seconds: 2),
//              autoPlay: true,
//
//              onPageChanged: (int index, carouselPageChangedReason) {
//                setState(() {
//                  pageIndex = index;
//                });
//              },
//              enlargeCenterPage: true,
//              enlargeStrategy: CenterPageEnlargeStrategy.scale,
//            ),
//            items: _demo
//                .map(
//                  (items) => GestureDetector(
//                    onTap: () {},
//                    child: Container(
//                      child: Container(
//                        // margin: EdgeInsets.all(5.0),
//                        child: items,
//                      ),
//                    ),
//                  ),
//                )
//                .toList(),
//          ),
          spaceH(20),
          CarouselIndicator(
            color: Colors.blueGrey,
            cornerRadius: 15,
            height: 10,
            width: 10,
            activeColor: customColor,
            count: _demo.length,
            index: pageIndex,
          ),
        ],
      ),
    );
  }
}
