// @dart=2.9

import 'package:flutter/material.dart';

import './controllers/menu_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './screens/home_page.dart';
import './screens/tree_details_screen.dart';
import './providers/node_provider.dart';

void main() {
  runApp(MyApp());
}

/// Let's start to make responsive website
/// First make app responsive class

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuController()),
        ChangeNotifierProvider(create: (context) => NodeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        home: HomePage(),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          TreeDetailsScreen.routeName: (ctx) => TreeDetailsScreen(),
        },
      ),
    );
  }
}
