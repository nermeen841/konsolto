import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/domain/notification/notification_repo_interf.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';

class NotificationRepo implements INotificationRepo {
  NetWorkData netWorkData = NetWorkData();
  @override
  Future getNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    return netWorkData
        .getData(url: Utils.BASE_URL + '/patients/notifications', headers: [
      {
        'Authorization': 'Bearer $token',
        'lang': sendapiLang(),
      }
    ]);
  }
}
