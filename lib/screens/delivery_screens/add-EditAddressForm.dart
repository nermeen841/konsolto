import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/screens/delivery_screens/mapDataPovider.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../sharedPreferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';

class AddEditAddressForm extends StatefulWidget {
  final String floor;
  final String flat;
  final String build;
  final String phone;
  final String note;
  final bool editAddress;
  final String addressId;

  const AddEditAddressForm(
      {Key key,
      this.floor,
      this.flat,
      this.build,
      this.phone,
      this.note,
      this.editAddress,
      this.addressId})
      : super(key: key);

  @override
  _AddEditAddressFormState createState() => _AddEditAddressFormState();
}

class _AddEditAddressFormState extends State<AddEditAddressForm> {
  String _name;
  String _builNum;
  String _flat;
  String _note;
  String _phone;
  String _floor;

  final _formKey = GlobalKey<FormState>();
  bool useLocation = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [adressFrom(), spaceH(10), _commen_button()],
    );
  }

  _addAddresstoApi({String address, String lat, String long}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    final id = preferences.getString('userDbId');

    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'lang': apiLang(),
      };
      Map<String, String> _body = {
        "address": address,
        "name": _name,
        "latitude": lat,
        "longitude": long,
        "note": _note,
        "floor": _floor,
        "buildingNo": _builNum,
        "flat": _flat,
        "mobile": _phone
      };
      var response = await http.post(Uri.parse(Utils.ADDADDRESS_URL + '/' + id),
          headers: requestHeaders, body: _body);
      var _data = json.decode(response.body);
      print(_data);
      if (_data['success'] == true) {
        MySharedPreferences.saveUserAddress(address);
        MySharedPreferences.saveUserlat(lat);
        MySharedPreferences.saveAddressBuildNum(_builNum);
        MySharedPreferences.saveaddressNote(_note);
        MySharedPreferences.savePhoneNum(_phone);
        MySharedPreferences.saveAddressFlatNum(_flat);
        MySharedPreferences.saveAddressFloorNum(_floor);
        MySharedPreferences.saveUserlong(long);
        Provider.of<HomeAddressProvider>(context, listen: false)
            .updataisAddNewAdress();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => SimplebottomNve(),
          ),
        );
        Provider.of<HomeAddressProvider>(context, listen: false)
            .updataisAddNewAdress();
      }
    } catch (e) {
      print('$e');
    }
  }

  editAddresstoApi({String address, String lat, String long}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    final userId = preferences.getString('userDbId');
    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'lang': apiLang(),
      };
      Map<String, String> _body = {
        "address": address,
        "name": _name ?? widget.note,
        "latitude": lat,
        "longitude": long,
        "note": _note ?? '',
        "floor": _floor ?? widget.floor,
        "buildingNo": _builNum ?? widget.build,
        "flat": _flat ?? widget.phone,
        "mobile": _phone ?? widget.phone
      };
      var response = await http.put(
          Uri.parse(Utils.EDIT_ADDRESS_URL + "${widget.addressId}/$userId"),
          headers: requestHeaders,
          body: _body);
      var _data = json.decode(response.body);
      print(_data);
      if (_data['success'] == true) {
        MySharedPreferences.saveUserAddress(address);
        MySharedPreferences.saveUserlat(lat);
        MySharedPreferences.saveAddressBuildNum(_builNum);
        MySharedPreferences.saveaddressNote(_note);
        MySharedPreferences.savePhoneNum(_phone);
        MySharedPreferences.saveAddressFlatNum(_flat);
        MySharedPreferences.saveAddressFloorNum(_floor);
        MySharedPreferences.saveUserlong(long);
        Provider.of<HomeAddressProvider>(context, listen: false)
            .updataisAddNewAdress();
        Navigator.of(context).pop();
        Provider.of<HomeAddressProvider>(context, listen: false)
            .updataisAddNewAdress();
      }
    } catch (e) {
      print('$e');
    }
  }

  adressFrom() {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          Card(
            elevation: .3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _addAddress_field(
                        TextInputType.number,
                        LocalKeys.BULD_NUM.tr(),
                        130,
                        LocalKeys.PHONE_VALIDATE.tr(),
                        (widget.editAddress) ? widget.build : "", (vale) {
                      setState(() {
                        _builNum = vale;
                      });
                    }),
                  ),
                  Expanded(
                    child: _addAddress_field(
                        TextInputType.text,
                        LocalKeys.ADDRESS_NAME.tr(),
                        190,
                        LocalKeys.TEXT_VALIDATE.tr(),
                        (widget.editAddress) ? widget.note : "", (vale) {
                      setState(() {
                        _name = vale;
                      });
                    }),
                  ),
                ],
              ),
            ),
          ),
          spaceH(10),
          Card(
            elevation: .3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _addAddress_field(
                        TextInputType.number,
                        LocalKeys.FLOOR_NUM.tr(),
                        130,
                        LocalKeys.TEXT_VALIDATE.tr(),
                        (widget.editAddress) ? widget.floor : "", (vale) {
                      setState(() {
                        _floor = vale;
                      });
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: _addAddress_field(
                        TextInputType.number,
                        LocalKeys.FLAT_NUM.tr(),
                        190,
                        LocalKeys.TEXT_VALIDATE.tr(),
                        (widget.editAddress) ? widget.flat : "", (vale) {
                      setState(() {
                        _flat = vale;
                      });
                    }),
                  ),
                ],
              ),
            ),
          ),
          spaceH(10),
          Card(
            elevation: .3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: _addAddress_field(
                TextInputType.text,
                LocalKeys.ADDRESS_NOTE.tr(),
                200,
                LocalKeys.TEXT_VALIDATE.tr(),
                '',
                (vale) {
                  setState(() {
                    _note = vale;
                  });
                },
              ),
            ),
          ),
          spaceH(10),
          Card(
            elevation: .3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: _addAddress_field(
                TextInputType.phone,
                LocalKeys.MOBILE_NUMBER.tr(),
                200,
                LocalKeys.TEXT_VALIDATE.tr(),
                (widget.editAddress) ? widget.phone : "",
                (vale) {
                  setState(() {
                    _phone = vale;
                  });
                  print(vale);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  _commen_button() {
    return InkWell(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              LocalKeys.DONE_BUTTON.tr(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          if (_formKey.currentState.validate()) {
            if (widget.editAddress == true) {
              print(
                  "____________________________________________________________YOU NOW EDITTING ADRESS");
              editAddresstoApi(
                address:
                    Provider.of<MapDataProvider>(context, listen: false).addres,
                lat: Provider.of<MapDataProvider>(context, listen: false).lat,
                long: Provider.of<MapDataProvider>(context, listen: false).long,
              );
            } else {
              print(
                  "____________________________________________________________YOU NOW ADDING NEW ADRESS");
              _addAddresstoApi(
                address:
                    Provider.of<MapDataProvider>(context, listen: false).addres,
                lat: Provider.of<MapDataProvider>(context, listen: false).lat,
                long: Provider.of<MapDataProvider>(context, listen: false).long,
              );
            }
          }
        });
  }

  // ignore: non_constant_identifier_names
  _addAddress_field(TextInputType type, String txt, double v, String validator,
      String initialValue, Function onChage) {
    return TextFormField(
      keyboardType: type,
      initialValue: initialValue,
      onChanged: onChage,
      validator: (val) => val.isEmpty ? validator : null,
      decoration: InputDecoration(
        hintText: txt,
        helperStyle: AppTheme.subHeading.copyWith(color: Colors.grey[100]),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}
