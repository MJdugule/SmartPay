import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/utilities/helper.dart';
import 'package:smartpay/utilities/pref_utils.dart';

class HomeScreen extends StatelessWidget {
  final String welcomeText;
  const HomeScreen({super.key, required this.welcomeText});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: safeAreaPadding,
        child: Column(
          children: [
                 verticalSpaceLarge,
            Row(
              children: [
                Text(
                  '${Helper().greeting()}, ${PrefUtils.getUserData()!.fullName.toString()}',
                  style: kLargeTextStyle.copyWith(
                    fontSize: 21,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            verticalSpaceTiny,
            Text(
              welcomeText,
              style: kRegularTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}