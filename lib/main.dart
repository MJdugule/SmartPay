import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/styles/themes.dart';
import 'package:smartpay/utilities/app_status_bar.dart';
import 'package:smartpay/utilities/pref_utils.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';
import 'package:smartpay/views/intro_screens/splash_screen.dart';

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();
void main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await PrefUtils.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //ios
      statusBarBrightness: PrefUtils.getUserThemePreference() == true
          ? Brightness.dark
          : Brightness.light,
      statusBarColor: Colors.transparent,
      //andriod
      statusBarIconBrightness: PrefUtils.getUserThemePreference() == true
          ? Brightness.light
          : Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ThemeProvider()),ChangeNotifierProvider(
            create: (BuildContext context) => AuthenticationProvider()),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return StatusBar(
          light: PrefUtils.getUserThemePreference() == true ? false : true,
          child: MaterialApp(
            title: 'SmartPay',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: SmartPayTheme.lightMode,
            darkTheme: SmartPayTheme.darkMode,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldKey,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
