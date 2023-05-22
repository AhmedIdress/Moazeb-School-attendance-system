import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/child_cubit/child_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/child_screen/calender_screen.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/child_screen/study_schedule.dart';

class ChildScreen extends StatelessWidget {
  const ChildScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ChildCubit>(context);
    cubit.init(id);
    return BlocConsumer<ChildCubit, ChildState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (/*state is ChildReInitialState ||*/
            state is GetDataSuccessfullyState) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(0, 102, 79, 1),
            body: SafeArea(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            AppRadius.r35,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.s16w,
                          vertical: AppSize.s16h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'Attendance',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'Student attendance in semester',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CalenderScreen(
                                          id: id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: const Color.fromRGBO(
                                            176,
                                            221,
                                            201,
                                            1,
                                          ),
                                          fontSize: AppFont.f18,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSize.s16h,
                              ),
                              child: SizedBox(
                                height: 150,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cubit.cards.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .5,
                                            decoration: BoxDecoration(
                                              color: cubit
                                                  .cards[index].backgroundColor,
                                            ),
                                          ),
                                          PositionedDirectional(
                                            top: 0,
                                            end: -AppSize.s35w,
                                            child: CustomPaint(
                                              painter: PathPainter(
                                                cubit.cards[index].maskColor,
                                              ),
                                              size: const Size(200, 200),
                                            ),
                                          ),
                                          PositionedDirectional(
                                            top: AppSize.s30h,
                                            start: AppSize.s16w,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: AppSize.s10h,
                                                  ),
                                                  child: Text(
                                                    cubit.cards[index].days
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                                Text(
                                                  cubit.cards[index].state,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PositionedDirectional(
                                            top: AppSize.s16h,
                                            end: AppSize.s16w,
                                            child: SvgPicture.asset(
                                              cubit.cards[index].icon,
                                              height: AppSize.s30h,
                                              width: AppSize.s30w,
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
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      context.push(StudySchedule(
                                        className: cubit
                                                .studentModel.data?.className ??
                                            '',
                                      ));
                                    },
                                    child: SizedBox(
                                      height: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: cubit
                                                    .schedule.backgroundColor,
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: AppSize.s16h,
                                              end: -AppSize.s25h,
                                              child: CustomPaint(
                                                painter: PathPainter(
                                                  cubit.schedule.maskColor,
                                                ),
                                                size: const Size(200, 200),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              start: AppSize.s35w,
                                              top: AppSize.s35h,
                                              child: Text(
                                                cubit.schedule.state,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: AppSize.s20h,
                                              end: AppSize.s25w,
                                              child: SvgPicture.asset(
                                                cubit.schedule.icon,
                                                width: AppSize.s30w,
                                                height: AppSize.s30h,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: AppSize.s10h,
                                  );
                                },
                                itemCount: 1,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: MediaQuery.of(context).size.height * 0.62,
                    child: SvgPicture.asset(
                      AppPath.bookIcon,
                    ),
                  ),
                  PositionedDirectional(
                    start: AppSize.s16w,
                    top: AppSize.s16h,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: AppSize.s60w,
                            height: AppSize.s60h,
                            decoration: BoxDecoration(
                              image: /*cubit.studentModel.data?.imageUrl == null
                                  ?*/
                                  DecorationImage(
                                image: AssetImage(
                                  AppPath.hima,
                                ),
                              )
                              //todo: remove
                              /*
                               : DecorationImage(
                                      image: NetworkImage(
                                          '$imageHost${cubit.studentModel.data?.imageUrl}' ??
                                              ''),
                                    )*/
                              ,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSize.s10h,
                            ),
                            child: Text(
                              cubit.studentModel.data?.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Text(
                            "Level ${cubit.studentModel.data?.grade}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            'class ${cubit.studentModel.data?.className}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.white,
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
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class PathPainter extends CustomPainter {
  PathPainter(this.color);

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(144.144, -82.4032);
    path.cubicTo(159.404, -83.5438, 178.242, -91.1142, 188.869, -80.1032);
    path.cubicTo(199.871, -68.7034, 189.661, -49.5693, 191.064, -33.788);
    path.cubicTo(192.043, -22.7626, 196.963, -12.7579, 195.832, -1.74693);
    path.cubicTo(194.445, 11.7609, 192.631, 25.7694, 183.88, 36.1529);
    path.cubicTo(173.722, 48.2073, 159.81, 57.8423, 144.144, 59.5901);
    path.cubicTo(127.593, 61.4365, 109.65, 57.0809, 97.3977, 45.8013);
    path.cubicTo(85.6392, 34.976, 85.3535, 17.3308, 81.4156, 1.84035);
    path.cubicTo(77.7822, -12.4526, 71.1334, -26.7636, 75.3592, -40.8928);
    path.cubicTo(79.6294, -55.1708, 91.2675, -66.0616, 104.027, -73.7615);
    path.cubicTo(116.032, -81.0067, 130.161, -81.358, 144.144, -82.4032);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
