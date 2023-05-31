import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/children_cubit/children_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/child_screen/child_screen.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/profile_screen.dart';

class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({Key? key}) : super(key: key);

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  PersistentBottomSheetController? _controller;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ChildrenCubit>(context);
    return BlocConsumer<ChildrenCubit, ChildrenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        String lang = Localizations.localeOf(context).languageCode;
        if (state is GetLoginDataSuccessfullyState) {
          return Scaffold(
            body: Stack(
              children: [
                CustomPaint(
                  size: Size(double.infinity, context.screenHeight * 0.5),
                  painter: _HeaderWavesPainter(AppColors.primary),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppSize.s150h,
                    right: AppSize.s16w,
                    left: AppSize.s16w,
                  ),
                  child: ListView.builder(
                    itemCount: cubit.loginData.students?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          context.push(
                            ChildScreen(
                              id: cubit.loginData.students![index].studentId,
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
                                    end: lang == 'en' ? -AppSize.s25h : null,
                                    start: lang == 'ar' ? -AppSize.s25h : null,
                                    child: CustomPaint(
                                      painter: PathPainter(
                                        AppColors.primaryBright,
                                      ),
                                      size: Size(AppSize.s200w, AppSize.s200h),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    bottom: -AppSize.s220h,
                                    start: lang == 'en' ? -AppSize.s130w : null,
                                    end: lang == 'ar' ? -AppSize.s130w : null,
                                    child: CustomPaint(
                                      painter: PathPainter(
                                        AppColors.primaryBright,
                                      ),
                                      size: Size(AppSize.s200w, AppSize.s200h),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    start: lang == 'en' ? AppSize.s72w : null,
                                    end: lang == 'ar' ? AppSize.s72w : null,
                                    bottom: AppSize.s35h,
                                    child: Text(
                                      cubit.loginData.students![index].name,
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
                                    end: lang == 'en' ? AppSize.s35w : null,
                                    start: lang == 'ar' ? AppSize.s35w : null,
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
                  end: lang == 'en' ? AppSize.s35w : null,
                  start: lang == 'ar' ? AppSize.s35w : null,
                  top: AppSize.s60h,
                  child: Builder(
                    builder: (BuildContext context) => InkWell(
                      onTap: () {
                        if (_controller != null) {
                          _controller?.close();
                          _controller = null;
                        } else {
                          _controller = Scaffold.of(context).showBottomSheet(
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
                        backgroundImage: AssetImage(AppPath.prof2),
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: Localizations.localeOf(context).languageCode == 'en'
                      ? AppSize.s20w
                      : null,
                  top: AppSize.s60h,
                  end: Localizations.localeOf(context).languageCode == 'ar'
                      ? AppSize.s20w
                      : null,
                  child: Text(
                    getLang(context, 'children'),
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
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
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
