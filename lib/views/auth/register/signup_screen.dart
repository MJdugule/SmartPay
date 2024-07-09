import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/app_spinner.dart';
import 'package:smartpay/res/widget/buttons.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/textfields.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';
import 'package:smartpay/views/auth/login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        padding: safeAreaPadding,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPBackButton(
                  pressState: () {
                    Navigator.of(context).pop();
                  },
                ),
                verticalSpaceMedium,
                verticalSpaceTiny,
                RichText(
                  text: TextSpan(
                      text: 'Create a ',
                      style: kLargeTextStyle.copyWith(
                        fontSize: 26,
                        // height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Smartpay\n',
                          style: kLargeTextStyle.copyWith(
                            fontSize: 26,
                            color: AppColor.kPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'account',
                          style: kLargeTextStyle.copyWith(
                            fontSize: 26,
                            // height: 1.5,
                          ),
                        ),
                      ]),
                ),
                verticalSpaceLarge,
                SPTextField(
                  hintText: 'Email',
                  errorText: authenticationProvider.email.error,
                  controller: emailController,
                  onChanged: (value) =>
                      authenticationProvider.validateEmail(value),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                verticalSpaceMedium,
                authenticationProvider.loading
                    ? const Center(child: AppSpinner())
                    : SPFlatButton(
                        pressState: () async {
                          if (!authenticationProvider.isValidEmail) {
                            authenticationProvider
                                .validateEmail(emailController.text);
                            return;
                          }

                          FocusScope.of(context).unfocus();
                          await authenticationProvider.submitEmailForSignUp();
                        },
                        active: authenticationProvider.isValidEmail,
                        textColor: kWhite,
                        text: "Sign Up",
                        buttonColor: AppColor.kGreyNeutral,
                      ),
                verticalSpaceMedium
              ],
            ),
            const AuthOrDivider(),
            verticalSpaceRegular,
            Row(
              children: [
                Expanded(
                    child: SPSocialFlatButton(
                        pressState: () {},
                        asset: kGoogleSvg,
                        buttonColor: kBlack)),
                horizontalSpaceRegular,
                Expanded(
                    child: SPSocialFlatButton(
                        pressState: () {},
                        asset: kAppleSvg,
                        buttonColor: kBlack)),
              ],
            ),
            verticalSpaceLarge,
            verticalSpaceLarge,
            verticalSpaceMedium,
            Column(
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Already have an account? ',
                      style: kRegularTextStyle.copyWith(
                          // height: 1.5,
                          fontSize: 16),
                      children: [
                        TextSpan(
                            text: 'Sign In',
                            style: kRegularTextStyle.copyWith(
                                color: AppColor.kPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: kFontSL),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).pop()),
                      ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
