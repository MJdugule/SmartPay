// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/utilities/pref_utils.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = PrefUtils.getUserThemePreference() == true
      ? ThemeMode.dark
      : ThemeMode.light;
  //bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      return SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    PrefUtils.saveUserThemePreference(isOn);
    notifyListeners();
  }
}

class SmartPayTheme {
  static final lightMode = ThemeData(
      scaffoldBackgroundColor: kWhite,
      fontFamily: 'Sf Pro',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: kMainColorDark),
      colorScheme: const ColorScheme.light(primary: AppColor.kPrimaryColor),
      iconTheme: const IconThemeData(
        color: kBlack, //change your color here
      ),
      textTheme:  TextTheme(
          headlineSmall: kLargeTextStyle,
          titleMedium: kRegularTextStyle,
          bodySmall: kFormHeaderTextStyle,
          titleLarge: kLargeTextStyleTwo,
          labelSmall: kBottomBarText),
      appBarTheme: const AppBarTheme(
        color: kWhite,
        iconTheme: IconThemeData(
          color: kBlack, //change your color here
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(backgroundColor: kWhite),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(
              color: AppColor.kGreyNeutral.shade50,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: kRed,
              // width: 1.5,
            ),
          ),
          
          focusedBorder: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(
              color: AppColor.kPrimaryColor.shade300,
              width: 1.5,
            ),
          )
          ));
  static final darkMode = ThemeData(
      scaffoldBackgroundColor: kBlack,
      fontFamily: 'Sf Pro',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kMainColorLight,
      ),
      colorScheme: const ColorScheme.dark(primary: AppColor.kPrimaryColor),
      iconTheme: const IconThemeData(
        color: kWhite, //change your color here
      ),
      textTheme: const TextTheme(
          headlineSmall: kLargeTextStyleDark,
          titleMedium: kRegularTextStyleDark,
          bodySmall: kFormHeaderTextStyleDark,
          titleLarge: kLargeTextStyleDarkTwo,
          labelSmall: kBottomBarTextDark),
      appBarTheme: const AppBarTheme(
        color: kBlack,
        iconTheme: IconThemeData(
          color: kWhite, //change your color here
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(backgroundColor: kBlack),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kMainColorFade,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: kRed,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kMainColorDark,
              width: 1.5,
            ),
          )));
}
