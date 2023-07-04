import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/child_cubit/child_cubit.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ChildCubit>(context);
    return BlocConsumer<ChildCubit, ChildState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LogsInitialState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade200
              : Colors.black.withOpacity(0.5),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Notification",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.s16w,
              vertical: AppSize.s16h,
            ),
            child: cubit.logs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No logs available',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppSize.s16w,
                          ),
                          child: SvgPicture.asset(AppPath.empty),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? cubit.logs[cubit.logs.length - index - 1]
                                                .action
                                                .toLowerCase() ==
                                            'in'
                                        ? Colors.black.withGreen(120)
                                        : Colors.black.withRed(190)
                                    : cubit.logs[cubit.logs.length - index - 1]
                                                .action
                                                .toLowerCase() ==
                                            'in'
                                        ? Colors.black.withGreen(120)
                                        : Colors.black.withRed(120),
                            borderRadius: BorderRadius.circular(AppRadius.r16)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSize.s16h,
                            horizontal: AppSize.s16w,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: AppRadius.r30,
                                backgroundImage: AssetImage(AppPath.user),
                              ),
                              SizedBox(
                                width: AppSize.s16w,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${cubit.studentModel.data?.name} moved at ${cubit.logs[cubit.logs.length - index - 1].logTime}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: AppSize.s10h,
                                    ),
                                    Text(
                                      'Status : ${cubit.logs[cubit.logs.length - index - 1].action}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: AppSize.s10h,
                      );
                    },
                    itemCount: cubit.logs.length,
                  ),
          ),
        );
      },
    );
  }
}
