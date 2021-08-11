import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static String sharedPrefUserLat = 'Lat';
  static String sharedPrefUserLong = 'Long';
  static String sharedPrefAppLang = 'AppLan';
  static String sharedPrefUserAddres = 'UserAddres';
  static String sharedPrefOrderNum = 'order_num';
  static String sharedPrefOrderID = 'order_id';
  static String sharedPrefOrderStatus = 'order_status';
  static String sharedPrefOrderDate = 'order_date';
  static String flatNum = 'flat_num';
  static String floorNum = 'floor_num';
  static String buildNum = 'build_num';
  static String addressID = 'address_id';
  static String note = 'note';
  static String mobileNum = 'mobile_num';
  static String sharedPrefApiLang = 'apiLang';

  //save data

  static Future<bool> saveorderStatus(String orderStatus) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefOrderStatus, orderStatus);
  }

  static Future<bool> saveApiLang(String apiLang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefApiLang, apiLang);
  }

  static Future<bool> saveaddressNote(String addNote) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(note, addNote);
  }

  static Future<bool> savePhoneNum(String phone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(mobileNum, phone);
  }

  static Future<bool> saveAddressID(String addressId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(addressID, addressId);
  }

  static Future<bool> saveAddressFlatNum(String addflatNum) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(flatNum, addflatNum);
  }

  static Future<bool> saveAddressFloorNum(String addfloorNum) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(floorNum, addfloorNum);
  }

  static Future<bool> saveAddressBuildNum(String addbuildNum) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(buildNum, addbuildNum);
  }

  static Future<bool> saveorderDate(String orderDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefOrderDate, orderDate);
  }

  static Future<bool> saveorderID(String orderID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefOrderID, orderID);
  }

  static Future<bool> saveorderNum(String orderNum) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefOrderNum, orderNum);
  }

  static Future<bool> saveAppLang(String appLang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefAppLang, appLang) ?? 'en';
  }

  static Future<bool> saveUserAddress(String userAddress) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserAddres, userAddress);
  }

  static Future<bool> saveUserlat(String userLat) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserLat, userLat);
  }

  static Future<bool> saveUserlong(String userLong) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserLong, userLong);
  }

// get data
  static getorderID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String orderID = preferences.getString(sharedPrefOrderID);
    return orderID;
  }

  static getAddnote() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String orderID = preferences.getString(note);
    return orderID;
  }

  static getMobilenum() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String orderID = preferences.getString(mobileNum);
    return orderID;
  }

  static getAddressID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String addressId = preferences.getString(addressID);
    return addressId;
  }

  static getBuildnum() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String buildnum = preferences.getString(buildNum);
    return buildnum;
  }

  static getFloornum() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String floornum = preferences.getString(floorNum);
    return floornum;
  }

  static getFlatnum() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String flatnum = preferences.getString(flatNum);
    return flatnum;
  }

  static getorderStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String orderstatus = preferences.getString(sharedPrefOrderStatus);
    return orderstatus;
  }

  static getorderDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String orderDate = preferences.getString(sharedPrefOrderDate);
    return orderDate;
  }

  static getorderNum() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String orderNum = preferences.getString(sharedPrefOrderNum);
    return orderNum;
  }

  static getUserLat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lat = preferences.getString(sharedPrefUserLat);
    return lat;
  }

  static getUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userAddres = preferences.getString(sharedPrefUserAddres);
    return userAddres;
  }

  static getUserlong() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String long = preferences.getString(sharedPrefUserLong);
    return long;
  }

  static getAppLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var appLang = preferences.getString(sharedPrefAppLang);
    return appLang;
  }

  static getApiLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var apiLang = preferences.getString(sharedPrefApiLang);
    return apiLang;
  }
}
