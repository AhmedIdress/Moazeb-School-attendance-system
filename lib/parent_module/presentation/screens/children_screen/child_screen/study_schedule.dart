import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/component/gradiant_widget.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/study_schedule_cubit/study_schedule_cubit.dart';

class StudySchedule extends StatelessWidget {
  const StudySchedule({Key? key, required this.className}) : super(key: key);
  final String className;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<StudyScheduleCubit>(context);
    String lang = Localizations.localeOf(context).languageCode;
    cubit.init(className, lang);
    return BlocConsumer<StudyScheduleCubit, StudyScheduleState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is StudyScheduleInitialState) {
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
                    : Colors.blueGrey.shade200,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.s16w,
                            ),
                            child: InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: AppColors.primaryBright,
                              ),
                            ),
                          ),
                          GradientWidget(
                            widget: Text(
                              getLang(context, 'study'),
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
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: context.screenHeight * .87,
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
                          height: context.screenHeight * 0.75,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.s10w,
                            ),
                            child: ListView.builder(
                              itemCount: cubit.times.period?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: context.screenHeight * .2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsetsDirectional.only(
                                            top: AppSize.s16h,
                                            start: AppSize.s16w,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: AppSize.s10h),
                                                child: Text(
                                                  cubit.times.period?[index]
                                                          ?.index
                                                          .toString() ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall,
                                                ),
                                              ),
                                              Text(
                                                cubit.times.period?[index]
                                                        ?.startTime
                                                        .toString() ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              Text(
                                                cubit.times.period?[index]
                                                        ?.endTime
                                                        .toString() ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        color: Colors.grey),
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
                                          margin: EdgeInsetsDirectional.only(
                                            start: AppSize.s16w,
                                            top: AppSize.s16h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: /*Colors.grey.shade300*/
                                                AppColors.primaryBright,
                                            borderRadius: BorderRadius.circular(
                                              AppRadius.r16,
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: double.infinity,
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: Center(
                                            child: Text(
                                              cubit.times.period?[index]?.name
                                                          .toLowerCase() ==
                                                      "Break".toLowerCase()
                                                  ? getLang(context, 'break')
                                                  : (cubit.dayData[cubit.times
                                                          .period?[index]?.name
                                                          .toLowerCase()] ??
                                                      ''),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                    color:
                                                        //AppColors.primaryBright
                                                        Colors.white,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
