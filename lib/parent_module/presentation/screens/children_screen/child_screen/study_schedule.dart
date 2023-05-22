import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
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
    cubit.init(className);
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
            backgroundColor: Colors.grey.shade200,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: GradientWidget(
                        widget: Text(
                          'Study schedule',
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
                  ),
                  Container(
                    height: context.screenHeight * .87,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            child: Row(
                              children: workDays.map((e) {
                                return Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cubit.setDay(e);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: e == cubit.day
                                              ? AppColors.primaryBright
                                              : null,
                                          borderRadius: BorderRadius.circular(
                                              AppRadius.r16)),
                                      child: Center(
                                        child: Text(
                                          e.substring(0, 3),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: e == cubit.day
                                                    ? Colors.white
                                                    : null,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
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
                                          padding: EdgeInsetsDirectional.only(
                                            end: AppSize.s16w,
                                            bottom: AppSize.s16w,
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
                                          child: Text(
                                            cubit.times.period?[index]?.name ==
                                                    "Break"
                                                ? "Break"
                                                : (cubit.dayData[cubit.times
                                                        .period?[index]?.name
                                                        .toLowerCase()] ??
                                                    ''),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                  color:
                                                      //AppColors.primaryBright
                                                      Colors.white,
                                                ),
                                            textAlign: TextAlign.end,
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
