import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/app_spinner.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/res/widget/textfields.dart';
import 'package:smartpay/viewmodels/authentication_viewmodel.dart';
import 'package:smartpay/views/auth/forgot_password/forgot_passord_screen.dart';
import 'package:smartpay/views/auth/register/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
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
                // SPBackButton(pressState: (){
                //   Navigator.of(context).pop();
                // },),
                verticalSpaceLarge,
                Row(
                  children: [
                    Text(
                      'Hi There! 👋',
                      style: kLargeTextStyle.copyWith(
                        fontSize: 24,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                verticalSpaceTiny,
                Text(
                  'Welcome back, Sign in to your account',
                  style: kRegularTextStyle.copyWith(fontSize: 16),
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
                verticalSpaceTiny,
                SPPasswordField(
                  obscureText: obscureText,
                  hintText: 'Password',
                  errorText: authenticationProvider.password.error,
                  controller: passwordController,
                  onChanged: (value) =>
                      authenticationProvider.validateSignUpPassword(value),
                ),
                verticalSpaceSmall,
                Container(
                  margin: const EdgeInsets.only(
                      right: kPaddingFIVE, top: kPaddingXL, bottom: kPaddingXL),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen()),
                    ),
                    child: Text(
                      "Forgot Password?",
                      textAlign: TextAlign.right,
                      style: kFormHeaderTextStyle.copyWith(
                        color: AppColor.kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                verticalSpaceSmall,
                authenticationProvider.loading
                    ? const Center(child: AppSpinner())
                    : SPFlatButton(
                        pressState: () async {
                          if (!authenticationProvider.isValidSignIn) {
                            return;
                          }
                          FocusScope.of(context).unfocus();
                          await authenticationProvider
                              .submitUserDetailsForSignIn();
                        },
                        active: authenticationProvider.isValidSignIn,
                        textColor: kWhite,
                        text: "Sign In",
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
            Column(
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: kRegularTextStyle.copyWith(
                          // height: 1.5,
                          fontSize: 16),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: kRegularTextStyle.copyWith(
                                color: AppColor.kPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: kFontSL),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return const SignUpScreen();
                                  }))),
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

class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: AppColor.kGreyNeutral.shade200,
        )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "OR",
            style: kRegularTextStyle,
          ),
        ),
        Expanded(
            child: Divider(
          color: AppColor.kGreyNeutral.shade200,
        )),
      ],
    );
  }
}
