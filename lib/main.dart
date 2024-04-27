import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interview/controller/logincontroller.dart';
import 'package:interview/controller/productcontroller.dart';
import 'package:interview/controller/profilecontroller.dart';
import 'package:interview/controller/registercontroller.dart';
import 'package:interview/screen_config.dart';
import 'package:interview/screens/homescreen.dart';
import 'package:interview/screens/loginscreen.dart';
import 'package:interview/screens/registerscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

SharedPreferences? sharedPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.getInstance().init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProdutController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: sharedPreferences!.getString("id") != null
            ? HomeScreen()
            : LoginScreen(),
      ),
    );
  }
}
