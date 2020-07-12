import 'package:flutter/material.dart';
import 'package:shopping/pages/HomePage.dart';
import 'package:shopping/pages/login.dart';

import 'package:provider/provider.dart';
import 'package:shopping/provider/provider_auth.dart';
import 'package:shopping/pages/splash.dart';
import 'package:shopping/components/data_retrive.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => UserProvider.initialize(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepOrange),
        home: ScreensController(),
      )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login_page();
      case Status.Authenticated:
        return HomePage();
      default:
        return Login_page();
    }
  }
}
