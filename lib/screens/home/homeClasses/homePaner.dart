import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/screens/CameraScreens/scanQRcodeApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePaner extends StatefulWidget {
  static String qrCode;
  @override
  _HomePanerState createState() => _HomePanerState();
}

class _HomePanerState extends State<HomePaner> {
  bool visible = true;

  getQrcode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    HomePaner.qrCode = preferences.getString('qr_code');
    return HomePaner.qrCode;
  }

  @override
  void initState() {
    this.getQrcode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: QRcodeApi.qrCode(HomePaner.qrCode),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['visit'] != null) {
              return Visibility(
                visible: visible,
                child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 7, right: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  visible = false;
                                });
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      minRadius: 20,
                                      maxRadius: 20,
                                      backgroundImage: (snapshot.data['visit']
                                                  ['doctor']['url'] ==
                                              null)
                                          ? AssetImage(
                                              'lib/images/logo icon.png')
                                          : NetworkImage(snapshot.data['visit']
                                              ['doctor']['url']),
                                      backgroundColor: Colors.white,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            snapshot.data['visit']['doctor']
                                                ['name'],
                                            style: AppTheme.heading
                                                .copyWith(fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            snapshot.data['visit']['doctor']
                                                ['title'],
                                            style: AppTheme.subHeading
                                                .copyWith(fontSize: 7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Q ${snapshot.data['visit']['patientQueue']}",
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Currently doctor sees Q ${snapshot.data['visit']['currentQueue']}',
                                            style: AppTheme.subHeadingColorBlue
                                                .copyWith(
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }
}
