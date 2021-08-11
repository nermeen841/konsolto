import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:konsolto/domain/single_category_data/single_cat_store.dart';
import 'package:konsolto/domain/sub_category_repo_interf/sub_category_repo.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/home/homeSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:konsolto/screens/pharmacy_category/sub_category_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/screens/home/homeClasses/cartItemBar.dart';

class PharmacyCategoryPage extends StatefulWidget {
  final String id;
  static int currentIndex = 0;
  static TabController _tabController;
  PharmacyCategoryPage({Key key, this.id}) : super(key: key);

  @override
  _PharmacyCategoryPageState createState() => _PharmacyCategoryPageState();
}

class _PharmacyCategoryPageState extends State<PharmacyCategoryPage> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.id != null) {
      return Scaffold(
        body: WhenRebuilderOr<SingleCatStore>(
          initState: (context, rm) =>
              rm.setState((s) => s.getSingleCat(this.widget.id)),
          observe: () => RM.get<SingleCatStore>(),
          builder: (context, model) => PharmacyCategory(),
          onWaiting: () => Loading(),
          onError: (error) =>
              IN.get<SingleCatStore>().getSingleCat(this.widget.id) == null
                  ? Text('$error')
                  : PharmacyCategory(),
        ),
      );
    }
    return Container();
  }
}

class PharmacyCategory extends StatefulWidget {
  @override
  _PharmacyCategoryState createState() => _PharmacyCategoryState();
}

class _PharmacyCategoryState extends State<PharmacyCategory>
    with TickerProviderStateMixin {
  PageController _controller = new PageController();
  final getsingleCatModel = IN.get<SingleCatStore>().getsingleCatModel;
  static const _kDuration = const Duration(milliseconds: 1);
  static const _kCurve = Curves.ease;
  var isPageCanChanged = true;

  SubcatRepo subCatRepo = SubcatRepo();
  TextEditingController _search = TextEditingController();

  bool hasCart = false;
  String cartTotal;
  String cartItems;

  _checkIfHasCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('hasCart') != null) {
      setState(() {
        hasCart = pref.getBool('hasCart');
      });
    }
    if (pref.getString('cartTotal') != null) {
      setState(() {
        cartTotal = pref.getString('cartTotal');
      });
    }
    if (pref.getString('cartItems') != null) {
      setState(() {
        cartItems = pref.getString('cartItems');
      });
    }
  }

  @override
  void initState() {
    this._checkIfHasCart();
    PharmacyCategoryPage._tabController = TabController(
        length: getsingleCatModel.data.category.categories.length,
        initialIndex: 0,
        vsync: this);
    super.initState();
    if (PharmacyCategoryPage._tabController.indexIsChanging) {
      PharmacyCategoryPage._tabController.animation.addListener(() {
        setState(() {
          PharmacyCategoryPage.currentIndex =
              PharmacyCategoryPage._tabController.previousIndex;
        });
        // onPageChange(PharmacyCategoryPage._tabController.previousIndex,
        //     p: _controller);
      });
    } else {
      PharmacyCategoryPage._tabController.addListener(() {
        setState(() {
          PharmacyCategoryPage.currentIndex =
              PharmacyCategoryPage._tabController.index;
        });
        // onPageChange(PharmacyCategoryPage._tabController.index, p: _controller);
      });
    }
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //determine which switch is
      isPageCanChanged = true;
      await _controller.animateToPage(index,
          duration: Duration(milliseconds: 1),
          curve: Curves
              .ease); //Wait for pageview to switch, then release pageivew listener
      isPageCanChanged = true;
    } else {
      PharmacyCategoryPage._tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: InkWell(
          onTap: () {
            showSearch(
              context: context,
              delegate: HomeSearch(),
            );
          },
          child: Row(children: [
            Icon(
              Icons.search,
              color: customColor,
            ),
            Text(LocalKeys.SEARCH_SCREAN_HINT.tr(),
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: customColor)),
          ]),
        ),
      ),
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
              return <Widget>[
                imageSliver(),
                // sliverTabBar(),
              ];
            },
            body: CustomTabView(
              itemCount: getsingleCatModel.data.category.categories.length,
              initPosition: PharmacyCategoryPage.currentIndex,
              tabBuilder: (context, index) => Text(
                getsingleCatModel.data.category.categories[index].name,
                style: GoogleFonts.roboto(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
              pageBuilder: (context, index) {
                return SubcatTabViewPage(
                  id: getsingleCatModel.data.category.categories[index].sId,
                );
              },
              onPositionChange: (index) {
                setState(() {
                  PharmacyCategoryPage.currentIndex = index;
                });
                _controller.animateToPage(index,
                    duration: Duration(milliseconds: 1), curve: Curves.ease);
              },
              onScroll: (position) => print('$position'),
            ),
          ),
          CartBottomBar(cartItems: cartItems, cartTotal: cartTotal)
        ],
      ),
    );
  }

  sliverTabBar() {
    return SliverAppBar(
      floating: false,
      elevation: 0,
      expandedHeight: 20,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        return TabBar(
          controller: PharmacyCategoryPage._tabController,
          isScrollable: true,
          labelColor: customColor,
          indicatorColor: customColor,
          onTap: (int index) {
            subCatRepo.getSubcat(
                getsingleCatModel.data.category.categories[index].sId);
          },
          labelStyle:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
          unselectedLabelColor: Colors.black54,
          unselectedLabelStyle:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
          tabs: List<Widget>.generate(
              getsingleCatModel.data.category.categories.length, (index) {
            return Tab(
              child: Text(
                getsingleCatModel.data.category.categories[index].name,
                style: GoogleFonts.roboto(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            );
          }),
        );
      }),
    );
  }

  imageSliver() {
    return SliverAppBar(
      floating: false,
      elevation: 0,
      expandedHeight: 300,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: 300,
          child: Stack(children: [
            PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: (val) {
                setState(() {
                  PharmacyCategoryPage.currentIndex = val;
                  PharmacyCategoryPage._tabController.index = val;
                });
                PharmacyCategoryPage._tabController = TabController(
                    length: getsingleCatModel.data.category.categories.length,
                    initialIndex: PharmacyCategoryPage.currentIndex,
                    vsync: this);
              },
              itemCount: getsingleCatModel.data.category.categories.length,
              itemBuilder: (BuildContext context, int index) {
                return new Material(
                    child: Container(
                        child: Stack(fit: StackFit.expand, children: [
                  customCachedNetworkImage(
                      url:
                          getsingleCatModel.data.category.categories[index].url,
                      fit: BoxFit.cover,
                      context: context),
                ])));
              },
            ),
            new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                child: new Center(
                  child: new SlidersPage_2(
                    controller: _controller,
                    itemCount:
                        getsingleCatModel.data.category.categories.length,
                    onPageSelected: (int page) {
                      setState(() {
                        PharmacyCategoryPage.currentIndex = page;
                        PharmacyCategoryPage._tabController.index = page;
                      });
                      _controller.animateToPage(
                        PharmacyCategoryPage.currentIndex,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ]),
        );
      }),
    );
  }

  _search_button() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: customColor,
          ),
          TextFormField(
            controller: _search,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: LocalKeys.SEARCH_SCREAN_HINT.tr(),
              hintStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: customColor),
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
class SlidersPage_2 extends AnimatedWidget {
  SlidersPage_2({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  final PageController controller;

  var itemCount;

  final ValueChanged<int> onPageSelected;

  final Color color;

  Widget _buildDot(int index) {
    return new Container(
      width: 25,
      child: new Center(
        child: new Material(
          color: (index == PharmacyCategoryPage.currentIndex)
              ? HexColor('#d0011a')
              : Colors.red.withOpacity(.5),
          type: (index == PharmacyCategoryPage.currentIndex)
              ? MaterialType.button
              : MaterialType.circle,
          child: new Container(
            width: 7,
            height: (index == PharmacyCategoryPage.currentIndex) ? 3 : 10,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class CustomTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Widget stub;
  final ValueChanged<int> onPositionChange;
  final ValueChanged<double> onScroll;
  final int initPosition;

  CustomTabView({
    @required this.itemCount,
    @required this.tabBuilder,
    @required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  TabController controller;
  int _currentCount;
  int _currentPosition;

  @override
  void initState() {
    _currentPosition = 0;
    controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();

    return Column(
      children: [
        SizedBox(height: 5),
        Container(
          alignment: Alignment.center,
          child: Container(
            height: 40,
            child: TabBar(
              isScrollable: true,
              controller: controller,
              labelColor: customColor,
              indicatorColor: customColor,
              labelStyle:
                  GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
              unselectedLabelColor: Colors.black54,
              unselectedLabelStyle:
                  GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
              tabs: List.generate(
                widget.itemCount,
                (index) => widget.tabBuilder(context, index),
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              widget.itemCount,
              (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange(_currentPosition);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll(controller.animation.value);
    }
  }
}
