import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/models/homeSearchApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/domain/get_recommended/recommended_store.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/models/cartModels.dart';
import 'package:konsolto/screens/delivery_screens/check_out_data.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:konsolto/screens/order_cart_tracking/recommend_product.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

addProductToCart({String id}) async {}

class CartSearch extends SearchDelegate {
  CartSearch()
      : super(
          searchFieldStyle: AppTheme.subHeadingColorBlue.copyWith(),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldLabel: LocalKeys.SEARCH_MESS_HINT.tr(),
        );
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   assert(context != null);
  //   final ThemeData theme = Theme.of(context);
  //   final ColorScheme colorScheme = theme.colorScheme;
  //   assert(theme != null);
  //   return theme.copyWith(
  //     appBarTheme: AppBarTheme(
  //       brightness: colorScheme.brightness,
  //       backgroundColor: colorScheme.brightness == Brightness.dark
  //           ? Colors.grey[900]
  //           : Colors.white,
  //       iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
  //       textTheme: theme.textTheme,
  //     ),
  //     inputDecorationTheme: searchFieldDecorationTheme ??
  //         InputDecorationTheme(
  //           hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
  //           border: InputBorder.none,
  //         ),
  //   );
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
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
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Provider.of<CartDataProvider>(context,
                                      listen: false)
                                  .addProductToCart(snapshot.data[index].sId);
                              Provider.of<CartProductProvider>(context,
                                      listen: false)
                                  .updateCartRemoveProduct();
                              Navigator.of(context).pop();
                              Provider.of<CartProductProvider>(context,
                                      listen: false)
                                  .updateCartRemoveProduct();
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        //  MycartPage()
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
                              Provider.of<CartDataProvider>(context,
                                      listen: false)
                                  .addProductToCart(snapshot.data[index].sId);
                              Provider.of<CartProductProvider>(context,
                                      listen: false)
                                  .updateCartRemoveProduct();
                              Navigator.of(context).pop();
                              Provider.of<CartProductProvider>(context,
                                      listen: false)
                                  .updateCartRemoveProduct();
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
      child: ListTile(
        title: Text(snapshot.data[index].name),
        leading: Container(
          height: 80,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: customCachedNetworkImage(
            fit: BoxFit.contain,
            context: context,
            url: snapshot.data[index].url,
          ),
        ),
      ),
    );
  }
}

class MycartPage extends StatefulWidget {
  static var counter;
  static bool isEmpty = false;

  MycartPage({Key key}) : super(key: key);

  @override
  _MycartPageState createState() => _MycartPageState();
}

class _MycartPageState extends State<MycartPage> {
  // ignore: unused_field
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<dynamic> homeData;
  String totalMyCart;

  _getTotalCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      totalMyCart = preferences.getString('cartTotal');
    });
  }

  @override
  void initState() {
    super.initState();
    this._getTotalCart();
  }

  final recommendedModel = IN.get<RecommendedStore>().recommendedModel;

// ignore: non_constant_identifier_names
  alignment_cont(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            spaceH(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () async {
                  if (recommendedModel != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecomendedproductPage()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutDataScreen()));
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      LocalKeys.NEXT.tr(),
                      style: AppTheme.heading.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (_) => SimplebottomNve(),
      //         ),
      //       );
      //     },
      //   ),
      //   title: Text(
      //     LocalKeys.MY_CART.tr(),
      //     style: AppTheme.headingColorBlue,
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
        child: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     showSearch(
                  //       context: context,
                  //       delegate: CartSearch(),
                  //     );
                  //   },
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border: Border.all(
                  //         color: customColorGray,
                  //         width: 1,
                  //       ),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Icon(
                  //               Icons.search,
                  //               color: customColorGray,
                  //             ),
                  //             SizedBox(width: 5),
                  //             Expanded(
                  //               child: Text(
                  //                 LocalKeys.SEARCH_MESS_HINT.tr(),
                  //                 style: AppTheme.subHeadingColorBlue.copyWith(
                  //                     fontSize: 14,
                  //                     color: customColorGray,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //             ),
                  //           ]),
                  //     ),
                  //   ),
                  // ),
                  Provider.of<CartProductProvider>(context).isRemovedfromCart
                      ? Container()
                      : ProductCard(),
                ],
              ),
            ),
          ),
          alignment_cont(context)
        ]),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<CartDataProvider>(context, listen: false).getMyCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<CartModels> cartProducts = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView.builder(
                itemCount: cartProducts.length,
                primary: true,
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          (cartProducts[index].isOffer != false)
                              ? Align(
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
                                        'Save 10 ' + LocalKeys.EGP.tr(),
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .65,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .65,
                                        child: Text(
                                          cartProducts[index].name ?? '',
                                          style: AppTheme.headingColorBlue,
                                        ),
                                      ),
                                      Text(
                                        cartProducts[index].formQuantity ?? "",
                                        style: AppTheme.subHeading,
                                      ),
                                      spaceH(3),
                                      Text(
                                        '${cartProducts[index].price ?? ""} ${LocalKeys.EGP.tr()}',
                                        style: AppTheme.subHeadingColorBlue,
                                      ),
                                      spaceH(3),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: CartData(
                                          id: cartProducts[index].id,
                                          name: cartProducts[index].name ?? "",
                                          price:
                                              cartProducts[index].price ?? '',
                                          url: cartProducts[index].url,
                                          width: 150.0,
                                          width2: 70.0,
                                          inCart: true,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 50,
                                    height: 80,
                                    child: customCachedNetworkImage(
                                      context: context,
                                      fit: BoxFit.contain,
                                      url: cartProducts[index].url,
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
                },
              ),
            );
          }
          return Container();
        });
  }
}
