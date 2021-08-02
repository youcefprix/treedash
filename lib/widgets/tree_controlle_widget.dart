import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class TreeControlleWidget extends StatelessWidget {
  const TreeControlleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.yellow,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(10),
      child: Text('data'),
    );
  }
}
