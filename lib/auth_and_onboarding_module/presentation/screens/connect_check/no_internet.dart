import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_khaldun/core/app_path.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(
                  AppPath.noWifi,
                ),
                height: 200.h,
                width: 200.w,
              ),
              Text(
                'ops! there is no internet',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'please open the internet',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
