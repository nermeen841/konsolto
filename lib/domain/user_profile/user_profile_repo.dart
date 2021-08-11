import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/domain/user_profile/user_profile_repo_intrf.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';

class ProfiledataRepo implements IProfiledataRepo {
  NetWorkData netWorkData = NetWorkData();

  @override
  Future getProfiledata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final id = pref.getString('userDbId');
    final token = pref.getString('userToken');

    return netWorkData.getData(
        url: 'https://sprint.konsolto.com/patients/profile/$id',
        headers: [
          {'Authorization': 'Bearer $token', 'lang': sendapiLang()}
        ]);
  }
}
