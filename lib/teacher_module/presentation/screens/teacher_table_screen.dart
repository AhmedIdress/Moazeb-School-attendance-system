import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/component/gradiant_widget.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/profile_screen.dart';
import 'package:ibn_khaldun/teacher_module/presentation/controllers/teacher_table/teacher_cubit.dart';
import 'package:ibn_khaldun/teacher_module/presentation/screens/class/class_screen.dart';

class TeacherTableScreen extends StatefulWidget {
  const TeacherTableScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherTableScreen> createState() => _TeacherTableScreenState();
}

class _TeacherTableScreenState extends State<TeacherTableScreen> {
  PersistentBottomSheetController? _controller;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TeacherCubit>(context);
    String lang = Localizations.localeOf(context).languageCode;
    cubit.init(lang);
    return BlocConsumer<TeacherCubit, TeacherState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TeacherInitialState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor:
                Theme.of(context).colorScheme.brightness == Brightness.light
                    ? Colors.grey.shade200
                    : Colors.blueGrey.shade400,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(),
                        PositionedDirectional(
                          top: -AppSize.s110h,
                          end: -AppSize.s100w,
                          child: Container(
                            width: context.screenWidth * 0.8,
                            height: context.screenHeight * 0.42,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryBright,
                                  blurRadius: 30,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                              shape: BoxShape.circle,
                              gradient: RadialGradient(colors: [
                                Colors.white,
                                AppColors.primaryBright,
                                Colors.white,
                                AppColors.primaryBright,
                                Colors.white,
                                AppColors.primaryBright,
                              ]),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          start: AppSize.s16w,
                          bottom: AppSize.s10h,
                          child: GradientWidget(
                            widget: Text(
                              getLang(context, 'scad'),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(color: AppColors.primary),
                            ),
                            gradient: LinearGradient(colors: [
                              AppColors.primary,
                              AppColors.primaryBright
                            ]),
                          ),
                        ),
                        PositionedDirectional(
                          top: AppSize.s2h,
                          end: AppSize.s10w,
                          child: Builder(
                            builder: (BuildContext context) => InkWell(
                              onTap: () {
                                if (_controller != null) {
                                  _controller?.close();
                                  _controller = null;
                                } else {
                                  _controller =
                                      Scaffold.of(context).showBottomSheet(
                                    (context) => SizedBox(
                                      height: context.screenHeight * 0.8,
                                      width: double.infinity,
                                      child: const ProfileScreen(),
                                    ),
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: AppRadius.r35,
                                backgroundImage: AssetImage(AppPath.user),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: context.screenHeight * .7,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          AppRadius.r20,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: AppSize.s16w,
                            end: AppSize.s16w,
                            top: AppSize.s16h,
                          ),
                          child: SizedBox(
                            height: context.screenHeight * .05,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    cubit.setDay(workDays[index]);
                                  },
                                  child: Container(
                                    width: context.screenWidth * 0.18,
                                    decoration: BoxDecoration(
                                        color: workDays[index] == cubit.day
                                            ? AppColors.primaryBright
                                            : null,
                                        borderRadius: BorderRadius.circular(
                                            AppRadius.r16)),
                                    child: Center(
                                      child: Text(
                                        lang == 'en'
                                            ? workDays[index].substring(0, 3)
                                            : workDaysAr[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color:
                                                  workDays[index] == cubit.day
                                                      ? Colors.white
                                                      : null,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: workDays.length,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.s10w,
                            ),
                            child: cubit.tablesDay.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        getLang(context, 'empty'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: AppSize.s16w,
                                        ),
                                        child: SvgPicture.asset(AppPath.empty),
                                      ),
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: cubit.tablesDay.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          context.push(ClassScreen(
                                            className: cubit
                                                .tablesDay[index].subjectCode
                                                .split('-')
                                                .last,
                                          ));
                                        },
                                        child: SizedBox(
                                          height: context.screenHeight * .2,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    top: AppSize.s16h,
                                                    start: AppSize.s16w,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    AppSize
                                                                        .s10h),
                                                        child: Text(
                                                          cubit.tablesDay[index]
                                                              .periodNo
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall,
                                                        ),
                                                      ),
                                                      Text(
                                                        cubit
                                                                .times
                                                                .period?[cubit
                                                                    .tablesDay[
                                                                        index]
                                                                    .periodNo]
                                                                ?.startTime
                                                                .toString() ??
                                                            '',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      ),
                                                      Text(
                                                        cubit
                                                                .times
                                                                .period?[cubit
                                                                    .tablesDay[
                                                                        index]
                                                                    .periodNo]
                                                                ?.endTime
                                                                .toString() ??
                                                            '',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                color: Colors.grey.shade200,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsetsDirectional
                                                      .only(
                                                    start: AppSize.s16w,
                                                    top: AppSize.s16h,
                                                  ),
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    end: AppSize.s16w,
                                                    bottom: AppSize.s16w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: /*Colors.grey.shade300*/
                                                        AppColors.primaryBright,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      AppRadius.r16,
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        cubit.tablesDay[index]
                                                            .subjectName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                            ?.copyWith(
                                                              color:
                                                                  //AppColors.primaryBright
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                      //////todo
                                                      SizedBox(
                                                        height: AppSize.s10h,
                                                      ),
                                                      Text(
                                                        cubit.tablesDay[index]
                                                            .subjectCode
                                                            .split('_')
                                                            .last,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                              color:
                                                                  //AppColors.primaryBright
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
