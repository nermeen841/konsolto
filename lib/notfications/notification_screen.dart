import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/domain/notification/notification_store.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/order_cart_tracking/mycart.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhenRebuilderOr<NotificationStore>(
          initState: (context, rm) => rm.setState((s) => s.getNotification()),
          observe: () => RM.get<NotificationStore>(),
          builder: (context, model) => NotificationScreen(),
          onWaiting: () => Loading(),
          onError: (error) =>
              IN.get<NotificationStore>().getNotification() == null
                  ? Text('$error')
                  : NotificationScreen()),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationModel = IN.get<NotificationStore>().notificationModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          LocalKeys.NOTIFICATION.tr(),
          style: AppTheme.headingColorBlue,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        primary: true,
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                primary: false,
                itemCount: notificationModel.data.notifications.length,
                itemBuilder: (context, index) {
                  return (notificationModel.data.notifications[index].removed ==
                          true)
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MycartPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 25,
                                      minRadius: 25,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        child: customCachedNetworkImage(
                                            context: context,
                                            url: notificationModel
                                                .data.notifications[index].icon,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    spaceW(10),
                                    SizedBox(
                                      width: 280,
                                      child: Text(
                                        notificationModel
                                            .data.notifications[index].msg,
                                        style: AppTheme.subHeadingColorBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH(10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat.d().format(DateTime.parse(
                                            notificationModel
                                                .data
                                                .notifications[index]
                                                .createdAt)) +
                                        " " +
                                        DateFormat.MMMM().format(DateTime.parse(
                                            notificationModel
                                                .data
                                                .notifications[index]
                                                .createdAt)) +
                                        " " +
                                        DateFormat.y().format(DateTime.parse(
                                            notificationModel
                                                .data
                                                .notifications[index]
                                                .createdAt)),
                                    style: AppTheme.subHeading,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                }),
          ),
        ],
      ),
    );
  }
}
