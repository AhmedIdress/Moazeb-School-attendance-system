import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/auth/auth_layout.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ProfileCubit>(context);
    cubit.getData();
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.s16w,
            vertical: AppSize.s16h,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  cubit.isParent ? cubit.parent.parentName : cubit.teacher.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: AppSize.s18h,
                    top: AppSize.s10h,
                  ),
                  child: Text(
                    '${cubit.isParent ? cubit.parent.email : cubit.teacher.email} | ${cubit.isParent ? cubit.parent.phoneNumber : cubit.teacher.phoneNumber}',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.blueGrey),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppRadius.r16,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.notifications_active,
                        ),
                        title: InkWell(
                          onTap: () {
                            HiveDataSource hive = HiveDataSource<bool>(
                                AppLocalDataKeys.cacheBoxName);
                            hive.get(AppLocalDataKeys.isParent)
                                ? context.push(const NotificationScreen())
                                : null;
                          },
                          child: Text(
                            getLang(context, "notification"),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.translate_outlined,
                        ),
                        title: Text(
                          getLang(context, 'lang'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        trailing: InkWell(
                          onTap: () {
                            cubit.changeLang();
                          },
                          child: Text(
                            getLang(
                                context, cubit.arabic ? 'arabic' : 'english'),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.primaryBright),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.lightbulb_outlined,
                        ),
                        title: Text(
                          getLang(context, 'theme'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        trailing: InkWell(
                          onTap: () {
                            cubit.changeTheme();
                          },
                          child: Text(
                            getLang(context, cubit.dark ? 'dark' : 'light'),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.primaryBright),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppSize.s20h,
                    bottom: AppSize.s16h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppRadius.r16,
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.help_outline_outlined,
                          ),
                          title: Text(
                            getLang(context, 'help'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.question_answer_outlined,
                          ),
                          title: Text(
                            getLang(context, 'contact'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.privacy_tip_outlined,
                          ),
                          title: Text(
                            getLang(context, 'policy'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppRadius.r16,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          context.pushReplacement(const AuthLayout());
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.logout_outlined,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            getLang(context, "logout"),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
