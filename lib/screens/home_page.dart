import 'package:flutter/material.dart';
import 'package:flutter_hr_management/widgets/header_widget.dart';
import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../controllers/menu_controller.dart';
import '../widgets/tree_details.dart';
import '../widgets/tree_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/dashboard.dart';
import './home_page.dart';
import '../widgets/side_bar_menu.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      key: Provider.of<MenuController>(context, listen: false).scaffoldKey,
      backgroundColor: AppColor.bgSideMenu,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Side Navigation Menu
            /// Only show in desktop
            if (AppResponsive.isDesktop(context))
              Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            Expanded(
              flex: 4,
              child: Dashboard(),
            ),
          ],
        ),
      ),
    );
  }
}
