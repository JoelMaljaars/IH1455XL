import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pwsdikketrekker/services/zermelo/zermelo.dart';
import 'package:zermelo/Zermelo.dart';
import 'login.dart';
import 'home.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';

Box? box;
ZermeloService? zermeloService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  box = await Hive.openBox('trekker');
  zermeloService = ZermeloService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool isLoggedIn() {
    dynamic accessToken = box!.get("access_token");
    dynamic school = box!.get("school");
    return accessToken is String &&
        accessToken.length > 10 &&
        school is String &&
        school.length > 2;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      title: 'Dèta',
      home: isLoggedIn() ? const HomeScreen() : LoginScreen(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
