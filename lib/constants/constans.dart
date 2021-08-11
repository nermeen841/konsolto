import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

const customColor = Color(0xfff0860a8);
const customColor2 = Color(0xfff0f75c8);
const customColorGold = Color(0xfff9B792C);
const sliderTextColor = Color(0xfff21496C);
const customColorRed = Color(0xffff42821);
const customColorGreen = Color(0xfff18de12);
const customColorGreen2 = Color(0xfff009a2e);
const sliderTextColorcontaint = Color(0xfff21496C);
const customColorIcon = Color(0xfff7D7D7D);
const customColorDivider = Color(0xfffe1e1e1);
const customColorGray = Color(0xfffe1e1e1);
const customColorbottomBar = Color(0xfffDBD8D2);
const String emailEror = 'الرجاء إدخال بريد إلكتروني';
const String passwordEror = 'الرجاء إدخال كليمة المرور';
const String conPasswordEror = 'الرجاء إدخال بريد إلكتروني';
const String nameEror = 'الرجاء إدخال الاسم';
const String phoneEror = 'الرجاء إدخال رقم الهاتف';
////////////////////////////////////////
validateMessge(String message) {
  return 'يجب ادخال ' + message;
}

////////////////////////
spaceH(double height) {
  return SizedBox(height: height);
}

spaceW(double width) {
  return SizedBox(width: width);
}

////////////////////////
homeBottomSheet({BuildContext context, Widget child, ShapeBorder shapeBorder}) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(5), topLeft: Radius.circular(5)),
    ),
    isDismissible: true,
    context: context,
    builder: (context) => child,
  );
}

///
customButtomSearsh({Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 80,
      color: Colors.purple[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
            size: 20,
          ),
          Text(
            'بحث',
            style: AppTheme.subHeading.copyWith(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

//coustmInkelmuneDrower({String title, Function onTap}) {
//  return InkWell(
//    onTap: onTap,
//    child: Container(
//      height: 50,
//      width: 120,
//      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//      color: customColor2,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//          Text(
//            title,
//            style: AppTheme.heading.copyWith(
//              color: Colors.white,
//            ),
//          ),
//          Icon(
//            Icons.arrow_circle_down,
//            color: Colors.white,
//            size: 20,
//          ),
//        ],
//      ),
//    ),
//  );
//}

////////////////////////////////////////////////////////////

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

String gitnewPrice({String descaound, String price}) {
  double oldPrice;
  oldPrice = double.parse(price) - double.parse(descaound);
  return oldPrice.toString();
}

/////////////////////////////////////
customCachedNetworkImage({String url, BuildContext context, BoxFit fit}) {
  try {
    if (url == null || url == '') {
      return Container(
        child: Image.asset("lib/images/logo icon.png"),
      );
    } else {
      return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: (Uri.parse(url).isAbsolute)
            ? CachedNetworkImage(
                imageUrl: url,
                fit: fit,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  return Image.asset("lib/images/logo icon.png");
                })
            : Image.asset("lib/images/logo icon.png"),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

/////////////////////////////////////////////////////////////
class LogoContainar extends StatelessWidget {
  final String text;
  const LogoContainar({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/logo.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          text ?? '',
          style: AppTheme.heading.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////////
// ignore: non_constant_identifier_names
get_product_total(int qty, int price, int delivery, int discount) {
  // ignore: non_constant_identifier_names
  int total_price;
  total_price = qty * (price - discount) + delivery;
  return total_price;
}

////////////////////////////////////////////////////////////
// Future<void> showMyDialog(
//     {BuildContext context, String messge, String txt, String txt2}) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Icon(
//                 FontAwesomeIcons.upload,
//                 color: customColor,
//               ),
//               Center(
//                 child: Text(
//                   messge,
//                   style: AppTheme.heading.copyWith(
//                     color: customColor,
//                   ),
//                 ),
//               ),
//               spaceH(10),
//               Divider(),
//               spaceH(10),
//               Align(
//                 alignment: Alignment.center,
//                 child: InkWell(
//                   child: Row(
//                     children: [
//                       Icon(
//                         FontAwesomeIcons.camera,
//                         color: customColor,
//                         size: 20,
//                       ),
//                       spaceW(10),
//                       Text(txt, style: AppTheme.subHeading),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => CameraScreen()));
//                   },
//                 ),
//               ),
//               spaceH(10),
//               Divider(),
//               spaceH(10),
//               Align(
//                 alignment: Alignment.center,
//                 child: InkWell(
//                   child: Row(
//                     children: [
//                       Icon(
//                         FontAwesomeIcons.image,
//                         color: customColor,
//                         size: 20,
//                       ),
//                       spaceW(10),
//                       Text(txt2, style: AppTheme.subHeading),
//                     ],
//                   ),
//                   onTap: () {},
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

//////////////////////////////////////////////////////////
PreferredSizeWidget customAppBar({String title}) => AppBar(
      centerTitle: true,
      toolbarHeight: 70,
      backgroundColor: customColor,
      title: Text(
        title,
        style: AppTheme.heading.copyWith(
          color: Colors.white,
        ),
      ),
    );

//////////////////////////////////////////////////////
class MyCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2 - 150, size.height / 2,
        size.width / 2, size.height / 2 + 30);

    path.quadraticBezierTo(
        size.width, size.height - 60, size.width + 80, size.height / 2 - 150);

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/////////////////////////////////////////////////////////////////////////////////
class CustomButton extends StatelessWidget {
  final String text;
  final Function onPress;
  CustomButton({this.onPress, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(10),
        color: customColor,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 150,
          height: 48,
          child: Text(
            text,
            style: AppTheme.heading.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////

class CustomButtonWithchild extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function onPress;
  CustomButtonWithchild({this.onPress, this.child, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(30),
        color: color,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: double.infinity,
          height: 48,
          child: child,
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////

void showSettingsPanel(
    {@required BuildContext context, @required Widget child, bool scroll}) {
  showModalBottomSheet(
    isScrollControlled: scroll,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    ),
    context: context,
    enableDrag: true,
    builder: (context) {
      return child;
    },
  );
}
/////////////////////////////////////////////////////////////////////////////////

class CustomAppBar extends StatelessWidget {
  final Widget child;
  const CustomAppBar({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: MyCliper(),
        child: Container(
          height: 220,
          padding: EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: AppTheme.containerBackground,
          ),
          child: child,
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////
customRaiseButtom({String text, Function onTap}) {
  // ignore: deprecated_member_use
  return RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: customColor,
    onPressed: onTap,
    child: Text(
      text,
      style: AppTheme.subHeading.copyWith(
        color: Colors.white,
      ),
    ),
  );
}
////////////////////////////////////////////////////////////////////////

class CustomCarouselSlider extends StatefulWidget {
  final bool reverse;
  final Function onTap;
  final List<dynamic> listOfObject;

  const CustomCarouselSlider({
    Key key,
    @required this.listOfObject,
    @required this.reverse,
    @required this.onTap,
  }) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> offer = widget.listOfObject;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 2),
                autoPlay: true,
                reverse: widget.reverse,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
              ),
              items: offer
                  .map(
                    (items) => Container(
                      child: Container(
                        // margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        items.imgUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: 40),
                                        Text(
                                          items.contant,
                                          style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          items.title,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////
class RatingStar extends StatelessWidget {
  final double rating;

  const RatingStar({
    Key key,
    @required this.rating,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
      rating: rating,
      size: 20,
      isReadOnly: true,
      filledIconData: Icons.star,
      color: Colors.yellow[700],
      halfFilledIconData: Icons.star_half,
      borderColor: Colors.yellow[900],
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      spacing: 2.0,
    );
  }
}

///////////////////////////////////////////////////////////
class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    @required this.item,
    @required this.child,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: UniqueKey(),
        background: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );
  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );
}

/////////////////////////////////////////////////////////////
InkWell customSocialMdiaBottom({Function onTap, IconData icon, Color color}) {
  return InkWell(
    onTap: onTap,
    child: Icon(
      icon,
      color: color,
      size: 35,
    ),
  );
}

//////////////////////////////////////////////////////////////////////
flitter({BuildContext context, Widget child}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => child,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    // isScrollControlled: true,
  );
}

/////////////////////////////////////////////////////////////
Future<void> share({String url, String title}) async {
  await FlutterShare.share(
    title: title,
    linkUrl: url,
  );
}

///
Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

// ------------------------------------------------------------------------

Future<void> launchToWhatsApp({
  @required String phoneNum,
  BuildContext context,
}) async {
  String url = 'https://wa.me/$phoneNum';
  try {
    await launch(url);
    // if (await canLaunch(url)) {

    // } else {
    //   showMyDialog(context);
    // }
  } catch (e) {
    print('erorr is: ' + e.toString());
  }
}
///////////////////////////////////////////////////////////

// ignore: non_constant_identifier_names
Widget Loading() {
  return Center(
    child: CupertinoActivityIndicator(
      radius: 17,
      animating: true,
    ),
  );
}

/////////////////////////////////////////////////////////////////////////
showInSnackBar(
    String value, Color color, GlobalKey<ScaffoldState> _scaffoldKey) {
  // ignore: deprecated_member_use
  _scaffoldKey.currentState.showSnackBar(
    new SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: color,
      content: Text(
        value,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    ),
  );
}

///////////////////////////////////////////////////////////////

String apiLang() {
  switch (Userdata.appLang) {
    case 'ar':
      return 'en';
      break;
    default:
      return 'ar';
  }
}

String sendapiLang() {
  switch (Userdata.apiLang) {
    case 'en':
      return 'en';
      break;
    case 'ar':
      return 'ar';
      break;
    default:
      return 'en';
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
