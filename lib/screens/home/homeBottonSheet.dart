import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/screens/delivery_screens/add_naw_address_data2.dart';
import 'package:konsolto/sharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'package:konsolto/models/homeBottomSheetApi.dart';

class HomeBottomSheet extends StatefulWidget {
  @override
  _HomeBottomSheetState createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return (Provider.of<HomeAddressProvider>(context).isAddNewAdress)
        ? Container()
        : Container(
            child: ListView(
              shrinkWrap: true,
              primary: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(LocalKeys.BOTTOM_SHEET_ADDRESS.tr(),
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey))),
                    ),
                    spaceH(10),
                    Divider(),
                    Container(
                      color: Colors.white,
                      child: FutureBuilder(
                        future: HomeBottomSheetApi.newAddress(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return (snapshot.data == null ||
                                    snapshot.data.isEmpty)
                                ? Container(
                                    child: Center(
                                      child:
                                          Text(LocalKeys.SEARCH_MESS_HINT.tr()),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                MySharedPreferences
                                                    .saveUserAddress(
                                                  snapshot.data[index].address,
                                                );

                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        SimplebottomNve(),
                                                  ),
                                                );
                                              },
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                // height: 19,
                                                child: Text(
                                                  (snapshot.data[index].address
                                                              .length >
                                                          40)
                                                      ? snapshot.data[index]
                                                              .address
                                                              .substring(
                                                                  0, 40) +
                                                          '...'
                                                      : snapshot
                                                          .data[index].address,
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                              )),
                                          spaceH(50),
                                        ],
                                      );
                                    },
                                  );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    spaceH(10),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddnewAddressData(
                                editAddress: false,
                              ),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(LocalKeys.ADD_NEW_ADDRESS.tr(),
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: customColor))),
                        ),
                      ),
                    ),
                    spaceH(10),
                  ],
                ),
              ],
            ),
          );
  }
}
