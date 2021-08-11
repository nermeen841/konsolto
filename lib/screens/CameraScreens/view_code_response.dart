import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/test_bottom_fab.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/CameraScreens/scanQRcodeApi.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCodeResponse extends StatefulWidget {
  final code;
  ViewCodeResponse({Key key, this.code}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ViewCodeResponseState();
}

class _ViewCodeResponseState extends State<ViewCodeResponse> {
  String url;
  _buildScanResult() {
    return Container(
      child: Text("Code is: ${widget.code}"),
    );
  }

  _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    if (url != '') {
      _launchInWebViewOrVC(url);
    }
    print(
        "__________________________________________________ QR CODE : ${widget.code}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              LocalKeys.QR_APP_BAR.tr(),
              style: AppTheme.headingColorBlue,
            ),
            leading: InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => SimplebottomNve(),
                    ),
                  );
                })),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: FutureBuilder(
            future: QRcodeApi.qrCode(widget.code),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['doctor'] != null) {
                  url = snapshot.data['doctor']['link'];
                  _launchInWebViewOrVC(snapshot.data['doctor']['link']);
                  return Container();
                } else if (snapshot.data['visit'] != null) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 60, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[300],
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 5, left: 5, right: 5),
                                child: CircleAvatar(
                                  maxRadius: 20,
                                  minRadius: 20,
                                  backgroundImage: (snapshot.data['visit']
                                              ['doctor']['url'] ==
                                          null)
                                      ? AssetImage('lib/images/logo icon.png')
                                      : NetworkImage(snapshot.data['visit']
                                          ['doctor']['url']),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    snapshot.data['visit']['doctor']['name'],
                                    style: AppTheme.heading,
                                  ),
                                  Text(
                                    snapshot.data['visit']['doctor']['title'],
                                    style: AppTheme.subHeading,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        spaceH(20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            "${LocalKeys.WELCOMETO.tr()} ${snapshot.data['visit']['doctor']['name']} ${LocalKeys.CLINICQUEUE.tr()}",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        spaceH(10),
                        Text(
                          "Q ${snapshot.data['visit']['patientQueue']}",
                          style: GoogleFonts.roboto(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: customColor),
                        ),
                        spaceH(10),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: customColor),
                          child: Text(
                            "${LocalKeys.DOCTORSEES.tr()} Q ${snapshot.data['visit']['currentQueue']}",
                            style:
                                AppTheme.heading.copyWith(color: Colors.white),
                          ),
                        ),
                        spaceH(20),
                        Text(
                          "${LocalKeys.EXPECT.tr()} ${snapshot.data['visit']['doctor']['name']}  ${LocalKeys.KONSOLTOQR.tr()}",
                          style: AppTheme.subHeading,
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Center(
                  child: Loading(),
                );
              }
            },
          ),
        ));
  }
}
