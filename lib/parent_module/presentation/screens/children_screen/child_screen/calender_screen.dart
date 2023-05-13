import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/extentions__helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_state.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CustomCalenderCubit>(context);
    cubit.init(id);
    return BlocConsumer<CustomCalenderCubit, CustomCalendarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is InitialCustomCalendarState) {
          return Scaffold(
            body: Center(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircularProgressIndicator()),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.182,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(
                                AppRadius.r24,
                              ),
                            )),
                      ),
                      PositionedDirectional(
                        top: AppSize.s42h,
                        start: AppSize.s16w,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: /*const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )*/
                              Text(
                            'back',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color.fromRGBO(
                                    176,
                                    221,
                                    201,
                                    1,
                                  ),
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        left: 0.0,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppSize.s16w,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.s16w,
                          ),
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(
                              AppRadius.r24,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  //todo
                                  cubit.previousMonth();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${cubit.displayDays[15].day.month}/${cubit.displayDays[15].day.year}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              InkWell(
                                onTap: () {
                                  // todo
                                  cubit.nextMonth();
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s16w),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSize.s10h),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.42,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(
                                AppRadius.r24,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.s16w,
                                vertical: AppSize.s16h,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: cubit.weekDays
                                        .map(
                                          (e) => Expanded(
                                            child: Center(
                                              child: Text(
                                                e.substring(0, 3),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  Expanded(
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(
                                          top: AppSize.s10h,
                                        ),
                                        itemCount: cubit.displayDays.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 7,
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.all(AppSize.s2w),
                                            child: CircleAvatar(
                                              backgroundColor: cubit
                                                          .displayDays[index]
                                                          .state ==
                                                      ''
                                                  ? Colors.white
                                                  : cubit.sColor[cubit
                                                      .displayDays[index]
                                                      .state],
                                              child: Center(
                                                child: Text(
                                                  cubit.displayDays[index].day
                                                      .day
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: cubit
                                                                    .displayDays[
                                                                        index]
                                                                    .day
                                                                    .month ==
                                                                cubit
                                                                    .displayDays[
                                                                        15]
                                                                    .day
                                                                    .month
                                                            ? cubit.displayDays[index]
                                                                        .state ==
                                                                    ''
                                                                ? null
                                                                : Colors.white
                                                            : Colors.grey,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSize.s16w),
                          height: context.screenHeight * 0.12,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(
                              AppRadius.r24,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total studying days',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Container(
                                width: AppSize.s60w,
                                height: AppSize.s60h,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.r24,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    cubit.monthAttendanceModel.total.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ////////todo
                        SizedBox(
                          height: context.screenHeight * 0.24,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.sColor2.length,
                            itemBuilder: (BuildContext context, int index) {
                              List list = [
                                cubit.monthAttendanceModel.absent,
                                cubit.monthAttendanceModel.present,
                                cubit.monthAttendanceModel.excused,
                              ];
                              return Container(
                                width: context.screenWidth * 0.285,
                                margin: EdgeInsets.only(
                                  top: AppSize.s10h,
                                  bottom: AppSize.s10h,
                                ),
                                decoration: BoxDecoration(
                                  color: cubit.sColor2[index],
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      AppRadius.r16,
                                    ),
                                    bottom: Radius.circular(AppRadius.r10),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontSize: 70),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppSize.s10w),
                                      child: Text(
                                        cubit.days[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: AppSize.s10w,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
