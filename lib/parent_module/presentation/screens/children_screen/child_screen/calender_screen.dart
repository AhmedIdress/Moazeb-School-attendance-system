import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_state.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);
  final Map<String, Color> sColor = const {
    'absent': Colors.red,
    'attend': Color.fromRGBO(0, 102, 79, 1),
    'execute': Colors.blueGrey,
  };
  final List<String> weekDays = const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CustomCalenderCubit>(context);
    return BlocConsumer<CustomCalenderCubit, CustomCalendarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          //appBar: AppBar(),
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
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
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
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
                              style: Theme.of(context).textTheme.headlineSmall,
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
                                  children: weekDays
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
                                          padding: EdgeInsets.all(AppSize.s2w),
                                          child: CircleAvatar(
                                            backgroundColor: cubit
                                                        .displayDays[index]
                                                        .state ==
                                                    ''
                                                ? Colors.white
                                                : sColor[cubit
                                                    .displayDays[index].state],
                                            child: Center(
                                              child: Text(
                                                cubit.displayDays[index].day.day
                                                    .toString(),
                                                style:
                                                    Theme.of(context)
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
                        padding: EdgeInsets.symmetric(horizontal: AppSize.s16w),
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(
                            AppRadius.r24,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total studying days'),
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
                                  '24',
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
                      Expanded(
                        child: Row(
                          children: sColor.values
                              .map<Widget>(
                                (value) => Expanded(
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: AppSize.s6w,
                                            left: AppSize.s6w,
                                            top: AppSize.s10h,
                                            bottom: AppSize.s14h),
                                        decoration: BoxDecoration(
                                          color: value,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(
                                                AppRadius.r16,
                                              ),
                                              bottom: Radius.circular(
                                                  AppRadius.r10)),
                                        ),
                                      ),
                                      Text(
                                        '22',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 70),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit.calcNewWay(
                date: cubit.today,
              );
            },
          ),
       */
        );
      },
    );
  }
}
