import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/delivery_screens/add_naw_address_data2.dart';
import 'package:konsolto/screens/delivery_screens/check_out_data.dart';
import 'package:konsolto/screens/delivery_screens/myAddresApi.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:konsolto/sharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class UserAddresses extends StatefulWidget {
  @override
  _UserAddressesState createState() => _UserAddressesState();
}

class _UserAddressesState extends State<UserAddresses> {
  getAddress() async {
    CheckoutDataScreen.address =
        await MySharedPreferences.getUserAddress() ?? "";
    CheckoutDataScreen.buildNum = await MySharedPreferences.getBuildnum() ?? "";
    CheckoutDataScreen.flatNum = await MySharedPreferences.getFlatnum() ?? "";
    CheckoutDataScreen.floorNum = await MySharedPreferences.getFloornum() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: MyAddressApi.newAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        print(
                            "________________________________________________________ ORDER ID: ${snapshot.data[index]['_id']}");
                        // MySharedPreferences.saveAddressID(
                        //     snapshot.data[index]['_id']);
                        MySharedPreferences.saveUserAddress(
                            snapshot.data[index]['address']);
                        MySharedPreferences.saveAddressBuildNum(
                            snapshot.data[index]['buildingNo']);
                        MySharedPreferences.saveAddressFlatNum(
                            snapshot.data[index]['flat']);
                        MySharedPreferences.saveAddressFloorNum(
                            snapshot.data[index]['floor']);
                        getAddress();
                        Provider.of<HomeAddressProvider>(context, listen: false)
                            .updataisAddNewAdress();
                        Navigator.of(context).pop();
                        Provider.of<HomeAddressProvider>(context, listen: false)
                            .updataisAddNewAdress();
                        CheckoutDataScreen.addressId =
                            snapshot.data[index]['_id'];
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                (snapshot.data[index]['name'] != null)
                                    ? Text(
                                        snapshot.data[index]['name'],
                                        style: AppTheme.headingColorBlue,
                                      )
                                    : Container(),
                              ],
                            ),
                            spaceH(10),
                            _address_container(
                                snapshot.data[index]['address'],
                                FontAwesomeIcons.mapMarker,
                                customColor,
                                15,
                                AppTheme.subHeadingColorBlue),
                            spaceH(5),
                            _address_container(
                                LocalKeys.BULD_NUM.tr() +
                                    " : ${snapshot.data[index]['buildingNo']}\n" +
                                    LocalKeys.APARTMENT.tr() +
                                    " : ${snapshot.data[index]['flat']}\n" +
                                    LocalKeys.FLOOR_NUM.tr() +
                                    " : ${snapshot.data[index]['floor']}",
                                FontAwesomeIcons.city,
                                Colors.black87,
                                15,
                                AppTheme.subHeading),
                            spaceH(10),
                            (snapshot.data[index]['mobile'] == null)
                                ? Container()
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.phoneAlt,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                      spaceW(5),
                                      Text(
                                          snapshot.data[index]['mobile']
                                              .toString(),
                                          style: AppTheme.subHeadingColorBlue)
                                    ],
                                  ),
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
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddnewAddressData(
                                      editAddress: true,
                                      long: snapshot.data[index]['longitude'],
                                      lat: snapshot.data[index]['latitude'],
                                      addressId: snapshot.data[index]['_id'],
                                      note: snapshot.data[index]['name'],
                                      flat: snapshot.data[index]['flat'],
                                      floor: snapshot.data[index]['floor'],
                                      build: snapshot.data[index]['buildingNo'],
                                      mobile: snapshot.data['mobile'],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          }),
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
        Padding(
            padding: EdgeInsets.only(top: 5),
            child: SizedBox(width: 270, child: Text(title, style: style))),
      ],
    );
  }
}
