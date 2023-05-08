import 'package:flutter/material.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/app_string.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/child_screen/child_screen.dart';

class ChildrenScreen extends StatelessWidget {
  const ChildrenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChildScreen(),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.s10h,
            ),
            child: Card(
              elevation: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s10w,
                  vertical: AppSize.s10h,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: AppRadius.r35,
                      backgroundImage: AssetImage(AppPath.hima),
                      /*
                      child: Text(
                        getLang(
                          context,
                          AppString.childName,
                        ).substring(0, 1),
                        style: TextStyle(fontSize: AppFont.f24,),
                      ),*/
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSize.s10h,
                      ),
                    ),
                    Text(
                      getLang(
                        context,
                        AppString.childName,
                      ),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    /*CustomText(
                      text: getLang(
                        context,
                        AppString.childName,
                      ),
                      fontSize: AppFont.f16,
                      fontWeight: FontWeight.bold,
                    ),*/
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSize.s10h,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getLang(
                            context,
                            AppString.level,
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        /*CustomText(
                          text: getLang(
                            context,
                            AppString.level,
                          ),
                          fontSize: AppFont.f16,
                          fontWeight: FontWeight.normal,
                        ),*/
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.s14w,
                          ),
                        ),
                        /*CustomText(
                          text: getLang(
                            context,
                            AppString.childClass,
                          ),
                          fontSize: AppFont.f16,
                          fontWeight: FontWeight.normal,
                        ),*/
                        Text(
                          getLang(
                            context,
                            AppString.childClass,
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
