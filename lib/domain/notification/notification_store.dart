import 'package:konsolto/data/notification/notification.dart';
import 'package:konsolto/domain/notification/notification_repo_interf.dart';

class NotificationStore {
  NotificationModel notificationModel;
  INotificationRepo iNotificationRepo;
  NotificationStore(this.iNotificationRepo);

  Future<NotificationModel> getNotification() async {
    notificationModel =
        NotificationModel.fromJson(await iNotificationRepo.getNotification());
    if (notificationModel.success == true) {
      print("------------------------------- SSUCCESSSS");
    }
    return notificationModel;
  }
}
