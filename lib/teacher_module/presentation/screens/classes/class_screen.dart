import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/children_cubit/children_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/child_screen/child_screen.dart';
import 'package:ibn_khaldun/teacher_module/presentation/controllers/classes_cubit/classes_cubit.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ClassesCubit>(context);
    return BlocConsumer<ClassesCubit, ClassesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GetLoginDataSuccessfullyState) {
          return Scaffold(
            body: Stack(
              children: [
                CustomPaint(
                  size: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.5),
                  painter: _HeaderWavesPainter(AppColors.primary),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppSize.s150h,
                    right: AppSize.s16w,
                    left: AppSize.s16w,
                  ),
                  child: ListView.builder(
                    itemCount: /*cubit.loginData.students?.length*/ 3,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChildScreen(
                                id: /*cubit.loginData.students![index].studentId*/
                                    '',
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSize.s10h,
                          ),
                          child: SizedBox(
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  PositionedDirectional(
                                    top: AppSize.s16h,
                                    end: -AppSize.s25h,
                                    child: CustomPaint(
                                      painter: PathPainter(
                                        AppColors.primaryBright,
                                      ),
                                      size: const Size(200, 200),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    bottom: -220,
                                    start: -120,
                                    child: CustomPaint(
                                      painter: PathPainter(
                                        AppColors.primaryBright,
                                      ),
                                      size: const Size(200, 200),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    start: AppSize.s72w,
                                    bottom: AppSize.s35h,
                                    child: Text(
                                      /*cubit.loginData.students![index].name*/
                                      '',
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
                                    end: AppSize.s35w,
                                    top: AppSize.s30h,
                                    child: CircleAvatar(
                                      radius: AppRadius.r30,
                                      backgroundImage: AssetImage(AppPath.hima),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                PositionedDirectional(
                  end: AppSize.s35w,
                  top: AppSize.s60h,
                  child: CircleAvatar(
                    radius: AppRadius.r35,
                    backgroundImage: AssetImage(AppPath.prof2),
                  ),
                ),
                PositionedDirectional(
                  start: AppSize.s20w,
                  top: AppSize.s60h,
                  child: Text(
                    'Your children are',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(body: Center(child: Text('Teacher')));
        }
      },
    );
  }
}

class _HeaderWavesPainter extends CustomPainter {
  _HeaderWavesPainter(this.color);

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final path = Path();

    path.lineTo(0, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.40,
        size.width * 0.5, size.height * 0.30);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.20, size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
