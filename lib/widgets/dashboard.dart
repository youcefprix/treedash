import 'package:flutter/material.dart';
import '/common/app_colors.dart';

import '../widgets/header_widget.dart';

import '../widgets/recruitment_data_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              /// Header Part
              HeaderWidget(),
              RecruitmentDataWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
