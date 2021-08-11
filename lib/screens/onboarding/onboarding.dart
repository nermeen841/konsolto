import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/authenticate/authenticate.dart';
import 'package:konsolto/screens/onboarding/slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  static bool onBoarding = false;

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  void initState() {
    this.checkIfOnboading();
    super.initState();
  }

  checkIfOnboading() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();

    if (_sp.getBool('onBoarding') == true) {
      setState(() {
        OnBoard.onBoarding = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (OnBoard.onBoarding == true) {
      return Authenticate();
    }
    return OnBoarding();
  }
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;
  PageController _controller = PageController();
  List<Widget> _pages = [
    CustomSlider(
      contant: LocalKeys.SLIDER_1.tr(),
      image: 'lib/images/clinic Que.png',
    ),
    CustomSlider(
      contant: LocalKeys.SLIDER_2.tr(),
      image: 'lib/images/recieve Rx.png',
    ),
    CustomSlider(
      contant: LocalKeys.SLIDER_3.tr(),
      image: 'lib/images/order pharmacy.png',
    ),
    CustomSlider(
      contant: LocalKeys.SLIDER_4.tr(),
      image: 'lib/images/img4.png',
    ),
  ];
  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: _onChanged,
                  itemBuilder: (context, int index) {
                    return _pages[index];
                  },
                ),
              ),
              SliderContoler(
                pages: _pages,
                currentPage: _currentPage,
                controller: _controller,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => Authenticate(),
                  ),
                  (routes) => false,
                );
              },
              child: Container(
                height: 35,
                width: 86,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_currentPage == (_pages.length - 1))
                        ? Container()
                        : InkWell(
                            child: Text(
                              LocalKeys.SKIP.tr(),
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                color: customColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              )),
                            ),
                            onTap: () async {
                              SharedPreferences _sp =
                                  await SharedPreferences.getInstance();
                              _sp.setBool('onBoarding', true);
                              final _token = _sp.getString('userToken');
                              (_token == null)
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Authenticate(),
                                      ))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SimplebottomNve(),
                                      ));
                            },
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliderContoler extends StatelessWidget {
  const SliderContoler({
    Key key,
    @required List<Widget> pages,
    @required int currentPage,
    @required PageController controller,
  })  : _pages = pages,
        _currentPage = currentPage,
        _controller = controller,
        super(key: key);

  final List<Widget> _pages;
  final int _currentPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              _pages.length,
              (int index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 13,
                  width: (index == _currentPage) ? 15 : 15,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (index == _currentPage) ? customColor : Colors.grey,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    if (_currentPage == (_pages.length - 1)) {
                      SharedPreferences _sp =
                          await SharedPreferences.getInstance();
                      _sp.setBool('onBoarding', true);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Authenticate(),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeInOutQuint,
                      );
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 86,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (_currentPage == (_pages.length - 1))
                              ? LocalKeys.START.tr()
                              : LocalKeys.NEXT.tr(),
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: customColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
