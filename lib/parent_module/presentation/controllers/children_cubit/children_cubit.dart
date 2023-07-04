import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/parent_module/data/models/notification_model.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

part 'children_state.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  ChildrenCubit() : super(ChildrenInitialState()) {
    print('create');
    getLoginData();
  }

  final BaseParentRepository _baseParentRepository = ParentRepository();
  late LoginData loginData;
  HiveDataSource<List<CustomNotificationModel>?> hiveNotification =
      HiveDataSource<List<CustomNotificationModel>?>(
          AppLocalDataKeys.cacheBoxName);
  List<CustomNotificationModel> listNotify = [];

  void getLoginData() async {
    loginData = await _baseParentRepository.getParentLoinData();
    buildSignal();
    emit(GetLoginDataSuccessfullyState());
  }

  void notify() {
    emit(NotificationSuccessfullyState());
  }

  void buildSignal() async {
    emit(ChildrenInitialState());
    listNotify = hiveNotification.get(AppLocalDataKeys.notify) ?? [];
    try {
      final hubConnection = HubConnectionBuilder()
          .withUrl("http://moazeb-001-site1.ftempurl.com/Notification2")
          .build();
      await hubConnection.start();
      if (kDebugMode) {
        print(hubConnection.state);
      }
      hubConnection.on("SendNotificationToUser", (list) {
        print(loginData.parentId);
        print(list?.last.toString());
        if (loginData.parentId == list?.last.toString()) {
          if (kDebugMode) {
            print(list);
          }
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: 'attendKey',
              groupKey: 'attendGroup',
              title: '${list?.first} ${list?[1]}',
              body: list?[2].toString(),
              //autoDismissible: ,
            ),
          );
          notify();
          listNotify.add(
            CustomNotificationModel(list?.first.toString() ?? "",
                list?[1].toString() ?? "", list?[2].toString() ?? ""),
          );
          hiveNotification.set(AppLocalDataKeys.notify, listNotify);
        }
        emit(NotificationConnectionState());
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
