import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingPharmacyScreen extends StatefulWidget {
  String statusMsg;
  double rating;

  RatingPharmacyScreen({Key key, @required this.statusMsg, @required this.rating}) : super(key: key);
  @override
  _RatingPharmacyScreenState createState() => _RatingPharmacyScreenState();
}

class _RatingPharmacyScreenState extends State<RatingPharmacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              widget.statusMsg,
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#0860A8")),
            ),
          ),
          Center(
            child: SmoothStarRating(
                allowHalfRating: true,
                onRated: (v) {},
                starCount: 5,
                size: 40.0,
                rating: widget.rating,
                isReadOnly: false,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star,
                color: customColor,
                borderColor: Colors.blue[200],
                spacing: 0.0),
          ),
        ],
      ),
    );
  }
}
