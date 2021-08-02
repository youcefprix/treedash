import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../common/app_responsive.dart';

import '../widgets/tree_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/profile_card_widget.dart';

class TreeDetails extends StatefulWidget {
  @override
  _TreeDetailsState createState() => _TreeDetailsState();
}

class _TreeDetailsState extends State<TreeDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Header Part

              TreeWidget(),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
