import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/connect_check/no_internet.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/onboarding/onboarding.dart';

class ConnectChick extends StatefulWidget {
  const ConnectChick({Key? key}) : super(key: key);

  @override
  State<ConnectChick> createState() => _ConnectChickState();
}

class _ConnectChickState extends State<ConnectChick> {
  ConnectivityResult? connect;

  @override
  void initState() {
    connectivity();
    super.initState();
  }

  void connectivity() async {
    connect = await Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: Connectivity().onConnectivityChanged.listen((event) {
        connect = event;
        setState(() {});
      }),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return (connect == ConnectivityResult.mobile ||
                connect == ConnectivityResult.wifi)
            ? Onboarding()
            : const NoInternet();
      },
    );
  }
/*Widget isSigned(){
    return CacheHelper.get(key: 'remember')??false?const BottomNavigationView():const OnBoardingView();
  }*/
}
