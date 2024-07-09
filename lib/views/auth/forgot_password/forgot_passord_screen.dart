import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/app_spinner.dart';
import 'package:smartpay/res/widget/buttons.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/textfields.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';
import 'package:smartpay/views/auth/forgot_password/verify_email.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

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
            verticalSpaceRegular,
            SvgPicture.asset(kVerifySvg),
            verticalSpaceMedium,
            Text(
              "Password Recovery",
              style: kLargeTextStyle.copyWith(
                fontSize: 24,
                // height: 1.5,
              ),
            ),
            verticalSpaceRegular,
            Text(
              "Enter your registered email below to receive password instructions",
              style: kRegularTextStyle.copyWith(fontSize: 16),
            ),
            verticalSpaceMedium,
            SPTextField(
              hintText: 'Email',
              errorText: authenticationProvider.email.error,
              controller: emailController,
              onChanged: (value) => authenticationProvider.validateEmail(value),
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const Spacer(),
            authenticationProvider.loading
                ? const Center(child: AppSpinner())
                : SPFlatButton(
                    pressState: () async {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const VerifyEmailScreen();
                      }));
                    },
                    active: true,
                    textColor: kWhite,
                    text: "Send me email",
                    buttonColor: AppColor.kGreyNeutral,
                  ),
            verticalSpaceMedium
          ],
        ),
      ),
    );
  }
}
