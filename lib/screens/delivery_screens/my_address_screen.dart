import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/delivery_screens/add_naw_address_data2.dart';
import 'package:konsolto/screens/delivery_screens/myAddresApi.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:provider/provider.dart';
import '../../sharedPreferences.dart';

class MyAddressScreen extends StatefulWidget {
  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          LocalKeys.MY_ADDRESSE.tr(),
          style: AppTheme.headingColorBlue,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              primary: true,
              shrinkWrap: true,
              padding:
                  EdgeInsets.only(top: 10, right: 10, bottom: 70, left: 10),
              children: [
                (Provider.of<HomeAddressProvider>(context).isAddNewAdress)
                    ? Container()
                    : FutureBuilder(
                        future: MyAddressApi.newAddress(),
                        builder: (context, snapshpt) {
                          if (snapshpt.hasData) {
                            if (snapshpt.data.isEmpty) {
                              return Container(
                                padding: EdgeInsets.only(top: 100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "lib/images/place.png",
                                      width: 200,
                                      height: 200,
                                    ),
                                    spaceH(20),
                                    Text(
                                      LocalKeys.EMPTYADDRESS.tr(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: HexColor('#d0011a'),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snapshpt.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshpt.data[index]['name'] ??
                                                    "",
                                                style:
                                                    AppTheme.headingColorBlue,
                                              ),
                                            ],
                                          ),
                                          spaceH(10),
                                          _address_container(
                                              snapshpt.data[index]['address'],
                                              FontAwesomeIcons.mapMarker,
                                              customColor,
                                              15,
                                              AppTheme.subHeadingColorBlue),
                                          spaceH(5),
                                          _address_container(
                                              LocalKeys.BULD_NUM.tr() +
                                                  " : ${snapshpt.data[index]['buildingNo']}\n" +
                                                  LocalKeys.APARTMENT.tr() +
                                                  " : ${snapshpt.data[index]['flat']}\n" +
                                                  LocalKeys.FLOOR_NUM.tr() +
                                                  " : ${snapshpt.data[index]['floor']}",
                                              FontAwesomeIcons.city,
                                              Colors.black87,
                                              15,
                                              AppTheme.subHeading),
                                          spaceH(10),
                                          (snapshpt.data[index]['mobile'] ==
                                                  null)
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
                                                        snapshpt.data[index]
                                                                ['mobile']
                                                            .toString(),
                                                        style: AppTheme
                                                            .subHeadingColorBlue)
                                                  ],
                                                ),
                                          InkWell(
                                            child: Container(
                                              width: 130,
                                              height: 40,
                                              margin: EdgeInsets.only(
                                                  left: 200, top: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.blue[200]),
                                              child: Center(
                                                child: Text(
                                                  LocalKeys.EDIT_ADDRESS.tr(),
                                                  style: AppTheme
                                                      .subHeadingColorBlue
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              MySharedPreferences
                                                  .saveAddressBuildNum(
                                                      snapshpt.data[index]
                                                          ['buildingNo']);
                                              MySharedPreferences
                                                  .saveAddressFlatNum(snapshpt
                                                      .data[index]['flat']);
                                              MySharedPreferences
                                                  .saveAddressFloorNum(snapshpt
                                                      .data[index]['floor']);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddnewAddressData(
                                                    editAddress: true,
                                                    long: snapshpt.data[index]
                                                        ['longitude'],
                                                    lat: snapshpt.data[index]
                                                        ['latitude'],
                                                    addressId: snapshpt
                                                        .data[index]['_id'],
                                                    build: snapshpt.data[index]
                                                        ['buildingNo'],
                                                    flat: snapshpt.data[index]
                                                        ['flat'],
                                                    floor: snapshpt.data[index]
                                                        ['floor'],
                                                    note: snapshpt.data[index]
                                                        ['name'],
                                                    mobile: snapshpt.data[index]
                                                        ['mobile'],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                          } else {
                            return Container(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: _commen_button(),
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
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: customColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            LocalKeys.ADD_NEW_ADDRESS.tr(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddnewAddressData(
                      editAddress: false,
                    )));
      },
    );
  }

  // ignore: non_constant_identifier_names
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
