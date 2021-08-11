import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/domain/get_recommended/recommended_store.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/models/cartModels.dart';
import 'package:konsolto/screens/delivery_screens/check_out_data.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:konsolto/screens/order_cart_tracking/recommend_product.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'carSearch.dart';

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

  @override
  void initState() {
    Provider.of<CartDataProvider>(context, listen: false).isEmpatyFun(false);
    super.initState();
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
                        builder: (context) => CheckoutDataScreen(
                          imagebase64: CutomImagePacker.imagebase64,
                        ),
                      ),
                    );
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => SimplebottomNve(),
              ),
            );
          },
        ),
        title: Text(
          LocalKeys.MY_CART.tr(),
          style: AppTheme.headingColorBlue,
        ),
        centerTitle: true,
      ),
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
                  searchBottonBar(context),
                  spaceH(10),
                  CutomImagePacker(),
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

  InkWell searchBottonBar(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: CartSearch(),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: customColorGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: customColorGray,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    LocalKeys.SEARCH_MESS_HINT.tr(),
                    style: AppTheme.subHeadingColorBlue.copyWith(
                        fontSize: 14,
                        color: customColorGray,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class CutomImagePacker extends StatefulWidget {
  static List<String> imagebase64 = [];
  @override
  _CutomImagePackerState createState() => _CutomImagePackerState();
}

class _CutomImagePackerState extends State<CutomImagePacker> {
  String totalMyCart;
  File _imageFile;

  List<File> _imagelist = [];
  @override
  Widget build(BuildContext context) {
    return addImage();
  }

  // ignore: non_constant_identifier_names
  _header_text(String txt) {
    return Text(
      txt,
      style: AppTheme.headingColorBlue,
    );
  }

  _loadPicker(ImageSource source, BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    // ignore: deprecated_member_use
    var picked = await imagePicker.getImage(source: source);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
        _imagelist.add(_imageFile);
        final bytes = _imageFile.readAsBytesSync();
        CutomImagePacker.imagebase64.add(bytes.toString());
      });
      Provider.of<CartDataProvider>(context, listen: false).isEmpatyFun(true);
    } else {
      Provider.of<CartDataProvider>(context, listen: false).isEmpatyFun(false);
    }

    Navigator.of(context).pop();
  }

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          LocalKeys.PHONE_SELECTION_TITLE.tr(),
          style: AppTheme.heading,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                LocalKeys.PHOTO_SELECT1.tr(),
                style: AppTheme.subHeading,
              ),
              onTap: () {
                _loadPicker(ImageSource.gallery, context);
              },
            ),
            ListTile(
              title: Text(
                LocalKeys.PHOTO_SELECT2.tr(),
                style: AppTheme.subHeading,
              ),
              onTap: () {
                _loadPicker(ImageSource.camera, context);
              },
            )
          ],
        ),
      ),
    );
  }

  addImage() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showPickOptionsDialog(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                FontAwesomeIcons.camera,
                color: customColor,
                size: 20,
              ),
              spaceW(10),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: _header_text(LocalKeys.UPLOAD_FILES.tr()),
              )
            ],
          ),
        ),
        spaceH(10),
        (_imagelist.isEmpty)
            ? Container()
            : Container(
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _imagelist.length + 1,
                    itemBuilder: (context, index) {
                      return (index == _imagelist.length)
                          ? InkWell(
                              onTap: () {
                                _showPickOptionsDialog(context);
                              },
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Container(
                                  height: 130,
                                  width: 100,
                                  margin: EdgeInsets.all(10),
                                  child: Image.file(
                                    _imagelist[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _imagelist.removeAt(index);
                                    });
                                    if (_imagelist.isEmpty) {
                                      Provider.of<CartDataProvider>(context,
                                              listen: false)
                                          .isEmpatyFun(false);
                                    }
                                  },
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black),
                                      child: Icon(
                                        Icons.clear,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            );
                    }),
              ),
      ],
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
              height: (Provider.of<CartDataProvider>(context).isEmpaty)
                  ? MediaQuery.of(context).size.height - 380
                  : MediaQuery.of(context).size.height - 250,
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
