import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';

import 'package:konsolto/constants/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneBottonSheet extends StatefulWidget {
  final List phoneList;

  const PhoneBottonSheet({Key key, this.phoneList}) : super(key: key);
  @override
  _PhoneBottonSheetState createState() => _PhoneBottonSheetState();
}

class _PhoneBottonSheetState extends State<PhoneBottonSheet> {
//  final userAddressModel = IN.get<UserAddressStore>().userAddressModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.phoneList.length,
      primary: true,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH(20),
            InkWell(
              onTap: () {
                launch("tel:${widget.phoneList[index]}");
              },
              child: Text(
                widget.phoneList[index],
                style: AppTheme.headingColorBlue,
              ),
            ),
            spaceH(5),
            Divider(
              color: customColorGray,
              thickness: 1,
            ),
            spaceH(5),
          ],
        );
      },
    );
  }
}
