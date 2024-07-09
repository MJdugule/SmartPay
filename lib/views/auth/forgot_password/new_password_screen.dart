import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/buttons.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/textfields.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: safeAreaPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPBackButton(
              pressState: () {
                Navigator.of(context).pop();
              },
            ),
            verticalSpaceMedium,
            Text(
              "Create New Password",
              style: kLargeTextStyle.copyWith(
                fontSize: 24,
                // height: 1.5,
              ),
            ),
            verticalSpaceRegular,
            Text(
              "Please, enter a new password below different from the previous password",
              style: kRegularTextStyle.copyWith(fontSize: 16),
            ),
            verticalSpaceMedium,
            SPPasswordField(
              hintText: 'New Password',
              errorText: authenticationProvider.password.error,
              controller: passwordController,
              onChanged: (value) =>
                  authenticationProvider.validateSignUpPassword(value),
              textInputAction: TextInputAction.next,
            ),
            verticalSpaceTiny,
            SPPasswordField(
              hintText: 'Confirm Password',
              errorText: null,
              controller: confirmPasswordController,
              onChanged: (value) =>
                  authenticationProvider.validateSignUpPassword(value),
              textInputAction: TextInputAction.next,
            ),
            const Spacer(),
            SPFlatButton(
              pressState: () async {},
              active: true,
              textColor: kWhite,
              text: "Create new password",
              buttonColor: AppColor.kGreyNeutral,
            ),
            verticalSpaceMedium
          ],
        ),
      ),
    );
  }
}
