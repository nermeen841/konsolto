import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/screens/discount_screens/monthly_med_discount.dart';

class MonthlyReportDiscount extends StatefulWidget {
  @override
  _MonthlyReportDiscountState createState() => _MonthlyReportDiscountState();
}

class _MonthlyReportDiscountState extends State<MonthlyReportDiscount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.4,
       
        backgroundColor: Colors.white,
        title: Text("Monthly Med Discounts",
            style: AppTheme.headingColorBlue.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: HexColor("#BB1D3C"))),
       
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        primary: true,
        shrinkWrap: true,
        children: [
          spaceH(10),
          Card(
            elevation: 0.3,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("lib/images/img1.png"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          spaceH(15),
          _build_title("How it works ?"),
          spaceH(7),
          _build_body(
              "-select your monthly med from search bar                                   -view discounts you get on your monthly medication                        -pay 10% up front from your next monthly med order when you recieve first monthly med order"),
          spaceH(10),
          _build_title("Frequently asked questions: "),
          spaceH(7),
          _build_sub_title("Q: Can i change my monthly med?"),
          spaceH(7),
          _build_body(
              "yes you can change befor your monthly med delivery time by 48 hours"),
          spaceH(7),
          _build_sub_title(
              "Q: if i want to discontinue the program how can i get mu upfront 10% of next order?"),
          spaceH(7),
          _build_body(
              "you will recieve it with your last order or if there is no last order will transfer to you after 10 days from cancellation request"),
          spaceH(7),
          _build_sub_title("Q: How you get the medician discounts ?"),
          spaceH(7),
          _build_body(
              "we negotiate money back policy with our contracted pharmacies to deliver best price for you to support you in your chronic diseases fight journey"),
          spaceH(7),
          _build_sub_title("Q: When can I request order cancellation ?"),
          spaceH(7),
          _build_body(
              "you can cancel order befor your monthly med delivery time by 48 hours"),
          spaceH(30),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonthlymedDiscountScreen(),
                  ));
            },
            child: Container(
              height: 40,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: customColor, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  "Next",
                  style: AppTheme.heading.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _build_title(String txt) {
    return Wrap(
      children: [
        Text(
          "$txt",
          style: GoogleFonts.roboto(
              fontSize: 18, fontWeight: FontWeight.bold, color: customColor),
        )
      ],
    );
  }

  _build_sub_title(String txt) {
    return Wrap(
      children: [
        Text(
          "$txt",
          style: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.bold, color: customColor),
        )
      ],
    );
  }

  _build_body(String txt2) {
    return Wrap(
      children: [
        Text(
          "$txt2",
          style: GoogleFonts.roboto(
              color: Colors.blue[500],
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
