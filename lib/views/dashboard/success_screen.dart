import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/app_spinner.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/utilities/pref_utils.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: safeAreaPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              kThumb,
              scale: 1.3,
            ),
            verticalSpaceMedium,
            Text(
              "Congratulations, ${PrefUtils.getUserData()!.fullName.toString()}",
              textAlign: TextAlign.center,
              style: kLargeTextStyle.copyWith(fontSize: 24),
            ),
            verticalSpaceSmall,
            Text(
              "You’ve completed the onboarding, \nyou can start using smartpay",
              textAlign: TextAlign.center,
              style: kRegularTextStyle.copyWith(fontSize: 16),
            ),
            verticalSpaceMedium,
            authenticationProvider.loading
                ? const Center(child: AppSpinner())
                : SPFlatButton(
              active: true,
              pressState: () async {
                authenticationProvider.getUser();
              },
              textColor: kWhite,
              text: "Get Started",
              buttonColor: AppColor.kGreyNeutral,
            ),
          ],
        ),
      ),
    );
  }
}
