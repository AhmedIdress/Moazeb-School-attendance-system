import 'package:flutter/material.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class StudySchedule extends StatelessWidget {
  const StudySchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: Text(
                'study schedule',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            )),
            Container(
              height: MediaQuery.of(context).size.height * .85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    AppRadius.r20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
