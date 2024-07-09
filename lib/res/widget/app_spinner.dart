import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 24,
      width: 24,
      child: Center(child: CircularProgressIndicator(
        strokeWidth: 5,
        color: AppColor.kGreyNeutral,
      )),
    );
  }
}