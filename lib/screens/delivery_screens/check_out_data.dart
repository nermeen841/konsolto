import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/cartModels.dart';
import 'package:konsolto/screens/delivery_screens/delivery_address.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import '../../sharedPreferences.dart';

class CheckoutDataScreen extends StatefulWidget {
  final List<String> imagebase64;
  static String address;
  static String buildNum;
  static String floorNum;
  static String flatNum;
  static String addressId;
  static String promoDesc;
  static double discount;

  const CheckoutDataScreen({Key key, this.imagebase64}) : super(key: key);
  @override
  _CheckoutDataScreenState createState() => _CheckoutDataScreenState();
}

class _CheckoutDataScreenState extends State<CheckoutDataScreen> {
  TextEditingController _orderNot = TextEditingController();
  TextEditingController _promCode = TextEditingController();
  final picker = ImagePicker();
  File _imageFile;
  String totalMyCart;

  List<File> _imagelist = [];

  bool isSwitched = false;
  bool loading = false;

  // ignore: non_constant_identifier_names
  _header_text(String txt) {
    return Text(
      txt,
      style: AppTheme.headingColorBlue,
    );
  }

  // ignore: non_constant_identifier_names

  _order_note(String txt, double x) {
    return Container(
      //  height: x,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        maxLines: null,
        maxLength: null,
        keyboardType: TextInputType.text,
        controller: _orderNot,
        decoration: InputDecoration(
            hintText: txt,
            hintStyle: AppTheme.subHeadingColorBlue,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }

  _commen_button(String txt) {
    return Container(
      height: 40,
      // margin: EdgeInsets.only( top: 60),
      decoration: BoxDecoration(
        color: customColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _commen_cont(Widget child, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  _address_container(
      String title, IconData icon, Color color, double x, TextStyle style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(
            icon,
            color: color,
            size: x,
          ),
        ),
        spaceW(10),
        Text(title, style: style),
      ],
    );
  }

  @override
  void initState() {
    this.getAddress();

    super.initState();
  }

  _submitOrder() async {
    print("PromoCodeBottomShect:${PromoCodeBottomShect.promCode.text}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    final userDbId = preferences.getString('userDbId');
    print(CheckoutDataScreen.addressId);
    if (token != null) {
      try {
        Map<String, String> requestHeaders = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
        var response = await http.get(Uri.parse(Utils.MYCART_URL),
            headers: requestHeaders);
        var thisDetails = json.decode(response.body);
        if (thisDetails != null) {
          double totalCart = 0;
          for (var singleProduct in thisDetails['data']['cart']['details']) {
            totalCart +=
                (singleProduct['quantity'] * singleProduct['product']['price']);
          }
          print(
              "___________________________________________________________ order Address : ${CheckoutDataScreen.addressId}");
          var _body = {
            "address": CheckoutDataScreen.addressId,
            "files": widget.imagebase64,
            "note": _orderNot.text,
            "promocode": PromoCodeBottomShect.promCode.text,
            "details": thisDetails['data']['cart']['details'],
            "totalPrice": totalCart,
            "useWallet": isSwitched,
          };
          var postingCartToOrder = await http.post(
              Uri.parse(Utils.CREATE_Order_URL + userDbId),
              headers: requestHeaders,
              body: jsonEncode(_body));

          var thisOrderDetails = json.decode(postingCartToOrder.body);
          if (thisOrderDetails != null) {
            if (thisOrderDetails['success'] == true) {
              preferences.remove('cartTotal');
              preferences.remove('hasCart');
              preferences.remove('cartItems');
              Provider.of<CartDataProvider>(context, listen: false).clearData();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SimplebottomNve()));
            } else {
              loadingFan();
            }
          } else {
            loadingFan();
          }
        } else {
          loadingFan();
        }
      } catch (e) {
        loadingFan();

        print("catch ERROR : $e");
      }
    } else {
      loadingFan();
    }
  }

  _check_promocode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    if (token != null) {
      try {
        Map<String, String> requestHeaders = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
        var response = await http.get(Uri.parse(Utils.MYCART_URL),
            headers: requestHeaders);
        var thisDetails = json.decode(response.body);
        if (thisDetails != null) {
          double totalCart = 0;
          for (var singleProduct in thisDetails['data']['cart']['details']) {
            totalCart +=
                (singleProduct['quantity'] * singleProduct['product']['price']);
          }
          print(
              "______________________________________________________ promoCode Address ID: ${CheckoutDataScreen.addressId}");
          var _body = jsonEncode(<String, dynamic>{
            "details": thisDetails['data']['cart']['details'],
            "address": CheckoutDataScreen.addressId,
            "promocode": _promCode.text,
            "totalPrice": totalCart,
            "useWallet": false,
          });

          var postingCartToOrder = await http.post(
              Uri.parse(Utils.BASE_URL + "/orders/checkpromocode"),
              headers: requestHeaders,
              body: _body);

          var promo_check = json.decode(postingCartToOrder.body);

          if (promo_check['success'] == true) {
            CheckoutDataScreen.promoDesc =
                promo_check['data']['order']['promoDescription'];
            CheckoutDataScreen.discount =
                promo_check['data']['order']['discount'];
            Navigator.pop(context);
          }
        }
      } catch (e) {
        print(
            "_________________________________________________________ PROMO CODE ERROR : $e");
      }
    }
  }

  alignment_cont(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocalKeys.TOTAL.tr(),
                  style: AppTheme.headingColorBlue
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  Provider.of<CartDataProvider>(
                        context,
                      ).totalPrice.toStringAsFixed(2) +
                      " " +
                      "${LocalKeys.EGP.tr()}",
                  style: AppTheme.subHeadingColorBlue,
                ),
              ],
            ),
            spaceH(10),
            Center(
              child: Text(
                LocalKeys.MY_CART_MESS.tr(),
                style: AppTheme.subHeading
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            spaceH(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  loadingFan();
                  _submitOrder();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      LocalKeys.SEND.tr(),
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

  loadingFan() {
    setState(() {
      loading = !loading;
    });
  }

  _promo_code_buttom() {
    return showSettingsPanel(
        scroll: false, context: context, child: PromoCodeBottomShect());
  }

  @override
  Widget build(BuildContext context) {
    return (Provider.of<HomeAddressProvider>(context).isAddNewAdress)
        ? Container()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                LocalKeys.CHECK_OUT.tr(),
                style: AppTheme.headingColorBlue,
              ),
            ),
            body: (loading)
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Stack(
                    children: [
                      alignment_cont(context),
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          children: [
                            _header_text(LocalKeys.DELIVERY_ADDRESS.tr()),
                            spaceH(10),
                            (CheckoutDataScreen.address == null ||
                                    CheckoutDataScreen.address == "")
                                ? Container()
                                : userAddressSelection(),
                            spaceH(10),
                            (CheckoutDataScreen.address == null ||
                                    CheckoutDataScreen.address == "")
                                ? _commen_cont(
                                    InkWell(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.mapMarker,
                                            size: 15,
                                            color: customColor,
                                          ),
                                          spaceW(5),
                                          Text(
                                            LocalKeys.ADD_DELIVERY_ADDRESS.tr(),
                                            style: AppTheme.subHeadingColorBlue
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeliveryAddressScreen()));
                                      },
                                    ),
                                    Colors.white)
                                : Container(),
                            spaceH(10),
                            _header_text(LocalKeys.ORDER_NOTE.tr()),
                            spaceH(10),
                            _order_note(LocalKeys.ORDER_NOTE_MESS.tr(), 100),
                            spaceH(10),
                            InkWell(
                              onTap: () => _promo_code_buttom(),
                              child: _commen_cont(
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "lib/images/voucher.png",
                                        width: 30,
                                      ),
                                      spaceW(5),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          LocalKeys.PROMO_CODE.tr(),
                                          style: AppTheme.subHeadingColorBlue
                                              .copyWith(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                  Colors.white),
                            ),
                            spaceH(10),
                            _header_text(LocalKeys.PAYMENT_METHODE.tr()),
                            spaceH(10),
                            _commen_cont(
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    spaceW(5),
                                    Text(
                                      LocalKeys.CASH_ON_DELIVERY.tr(),
                                      style: AppTheme.subHeading.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                Colors.white),
                            spaceH(10),
                            _commen_cont(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocalKeys.SUB_TOTAL.tr(),
                                          style: AppTheme.subHeading,
                                        ),
                                        Text(
                                          Provider.of<CartDataProvider>(
                                                context,
                                              ).totalPrice.toStringAsFixed(2) +
                                              " " +
                                              "${LocalKeys.EGP.tr()}",
                                          style: AppTheme.subHeading,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocalKeys.DELIVERY_FEES.tr(),
                                          style: AppTheme.subHeading,
                                        ),
                                        Text(
                                          LocalKeys.UP_TO.tr() +
                                              " 10 " +
                                              LocalKeys.EGP.tr(),
                                          style: AppTheme.subHeading,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocalKeys.DISCOUNT.tr(),
                                          style: AppTheme.subHeading
                                              .copyWith(color: Colors.red),
                                        ),
                                        Text(
                                          "0 " + LocalKeys.EGP.tr(),
                                          style: AppTheme.subHeading,
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LocalKeys.TOTAL.tr(),
                                          style: AppTheme.subHeading,
                                        ),
                                        Text(
                                          Provider.of<CartDataProvider>(
                                                context,
                                              ).totalPrice.toStringAsFixed(2) +
                                              " " +
                                              "${LocalKeys.EGP.tr()}",
                                          style: AppTheme.subHeading,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Colors.white),
                            spaceH(10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    LocalKeys.USE_MY_CREDIT.tr(),
                                    style: AppTheme.headingColorBlue,
                                  ),
                                ),
                                Transform.scale(
                                  scale: 0.9,
                                  child: Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched = value;
                                        print(isSwitched);
                                      });
                                    },
                                    activeTrackColor: Colors.red,
                                    activeColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            spaceH(20),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
  }

  userAddressSelection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                addressContainer(
                    CheckoutDataScreen.address,
                    FontAwesomeIcons.mapMarker,
                    customColor,
                    15,
                    AppTheme.subHeadingColorBlue),
              ]),
          spaceH(5),
          addressContainer(
              LocalKeys.BULD_NUM.tr() +
                  " : ${CheckoutDataScreen.buildNum}\n" +
                  LocalKeys.APARTMENT.tr() +
                  " : ${CheckoutDataScreen.flatNum}  " +
                  LocalKeys.FLOOR_NUM.tr() +
                  " : ${CheckoutDataScreen.floorNum}",
              FontAwesomeIcons.city,
              Colors.black87,
              15,
              AppTheme.subHeading),
          InkWell(
            child: Container(
              width: 130,
              height: 40,
              margin: EdgeInsets.only(left: 200, top: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[200]),
              child: Center(
                child: Text(
                  LocalKeys.EDIT_ADDRESS.tr(),
                  style: AppTheme.subHeadingColorBlue
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeliveryAddressScreen()));
            },
          )
        ],
      ),
    );
  }

  addressContainer(
      String title, IconData icon, Color color, double x, TextStyle style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(
            icon,
            color: color,
            size: x,
          ),
        ),
        spaceW(10),
        Padding(
            padding: EdgeInsets.only(top: 5),
            child: SizedBox(width: 270, child: Text(title, style: style))),
      ],
    );
  }

  _loadPicker(ImageSource source, BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    // ignore: deprecated_member_use
    var picked = await imagePicker.getImage(source: source);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
        final bytes = _imageFile.readAsBytesSync();
        _imagelist.add(_imageFile);
        widget.imagebase64.add(bytes.toString());
      });
    }
    Navigator.of(context).pop();
  }

  getAddress() async {
    CheckoutDataScreen.address =
        await MySharedPreferences.getUserAddress() ?? "";
    CheckoutDataScreen.buildNum = await MySharedPreferences.getBuildnum() ?? "";
    CheckoutDataScreen.flatNum = await MySharedPreferences.getFlatnum() ?? "";
    CheckoutDataScreen.floorNum = await MySharedPreferences.getFloornum() ?? "";
    // CheckoutDataScreen.addressId =
    //     await MySharedPreferences.getAddressID() ?? "";
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
              title: Text(LocalKeys.PHOTO_SELECT1.tr()),
              onTap: () {
                _loadPicker(ImageSource.gallery, context);
              },
            ),
            ListTile(
              title: Text(LocalKeys.PHOTO_SELECT2.tr()),
              onTap: () {
                _loadPicker(ImageSource.camera, context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class PromoCodeBottomShect extends StatefulWidget {
  static TextEditingController promCode = TextEditingController();

  @override
  _PromoCodeBottomShectState createState() => _PromoCodeBottomShectState();
}

class _PromoCodeBottomShectState extends State<PromoCodeBottomShect> {
  double height = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: [
          _header_text(LocalKeys.PROMO_CODE.tr()),
          spaceH(10),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: customColorGray,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: PromoCodeBottomShect.promCode,
              onTap: () {
                setState(() {
                  height = 400;
                });
              },
              decoration: InputDecoration(
                  hintText: '',
                  hintStyle: AppTheme.subHeadingColorBlue,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
            ),
          ),
          spaceH(10),
          InkWell(
            onTap: () {
              _check_promocode();
            },
            child: _commen_button(LocalKeys.APPLY_BUTTON.tr()),
          ),
        ],
      ),
    );
  }

  _header_text(String txt) {
    return Text(
      txt,
      style: AppTheme.headingColorBlue,
    );
  }

  _check_promocode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    print('Taaaaadd');

    if (token != null) {
      try {
        Map<String, String> requestHeaders = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
        var response = await http.get(Uri.parse(Utils.MYCART_URL),
            headers: requestHeaders);
        var thisDetails = json.decode(response.body);
        if (thisDetails != null) {
          double totalCart = 0;
          for (var singleProduct in thisDetails['data']['cart']['details']) {
            totalCart +=
                (singleProduct['quantity'] * singleProduct['product']['price']);
          }
          var _body = jsonEncode(<String, dynamic>{
            "details": thisDetails['data']['cart']['details'],
            "address": CheckoutDataScreen.addressId,
            "promocode": PromoCodeBottomShect.promCode.text,
            "totalPrice": totalCart,
            "useWallet": false,
          });

          var postingCartToOrder = await http.post(
              Uri.parse(Utils.BASE_URL + "/orders/checkpromocode"),
              headers: requestHeaders,
              body: _body);

          var promo_check = json.decode(postingCartToOrder.body);

          if (promo_check['success'] == true) {
            print(
              "------------------------------------------- PROMOCODE :   $promo_check",
            );
            Navigator.pop(context);
          } else {
            print('SUCCC EROORO');
          }
        } else {
          print('DATTA NULL');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('TOOOTKEN NULL');
    }
  }

  _commen_button(String txt) {
    return Container(
      height: 40,
      // margin: EdgeInsets.only( top: 60),
      decoration: BoxDecoration(
        color: customColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
