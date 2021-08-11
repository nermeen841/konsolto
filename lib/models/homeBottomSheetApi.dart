import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';

class AddressData {
  bool removed;
  String sId;
  String address;
  String patient;
  String name;
  String floor;
  String flat;
  String buildingNo;
  String createdAt;
  String updatedAt;
  int iV;

  AddressData({
    this.removed,
    this.sId,
    this.address,
    this.patient,
    this.name,
    this.floor,
    this.flat,
    this.buildingNo,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });
}

class HomeBottomSheetApi {
  static Future<List<AddressData>> newAddress() async {
    List<AddressData> listOfaddressData = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    final id = preferences.getString('userDbId');
    try {
      var response = await http.get(
        Uri.parse(
          Utils.BASE_URL + '/addresses/all/$id',
        ),
        headers: {
          'Authorization': '  Bearer $token',
          'lang': Userdata.apiLang,
        },
      );
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        for (var address in jsonData['data']['addresses']) {
          AddressData addressData = AddressData(
            sId: address['_id'],
            removed: address['removed'],
            patient: address['patient'],
            name: address['name'],
            flat: address['flat'],
            buildingNo: address['buildingNo'],
            address: address['address'],
          );

          listOfaddressData.add(addressData);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfaddressData;
  }
}
