import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/boarding/boarding_cubit.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/boarding/boarding_state.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/auth/auth_layout.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class Onboarding extends StatelessWidget {
  Onboarding({Key? key}) : super(key: key);
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<BoardingCubit>(context);
    return BlocConsumer<BoardingCubit, BoardingState>(
      listener: (context, state) {
        if (state is NextBoardingState) {
          _controller.nextPage(
            duration: const Duration(microseconds: 350),
            curve: Curves.easeInCirc,
          );
        } else if (state is EndBoardingState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AuthLayout(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          //appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.s20h,
              horizontal: AppSize.s16w,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.boardings.length,
                    onPageChanged: (value) {
                      cubit.changeValue(value);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            cubit.boardings[index].image,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: AppSize.s10h),
                            child: Text(
                              cubit.boardings[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                          Text(
                            cubit.boardings[index].subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.grey.withOpacity(0.2),
                                  decorationThickness: 10,
                                ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 90,
                  height: 90,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircularProgressIndicator(
                          value: cubit.circleValue,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: IconButton(
                          onPressed: () {
                            cubit.next();
                          },
                          icon: Icon(
                            cubit.currentIndex == cubit.boardings.length - 1
                                ? Icons.check
                                : Icons.arrow_forward,
                            size: 40,
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
