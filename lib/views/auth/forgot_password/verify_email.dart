import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/res/widget/buttons.dart';
import 'package:smartpay/res/widget/flat_button.dart';
import 'package:smartpay/views/auth/forgot_password/new_password_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
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
            SvgPicture.asset(kRecoverySvg),
            verticalSpaceMedium,
            Text(
              "Verify your Identity",
              style: kLargeTextStyle.copyWith(
                fontSize: 24,
                // height: 1.5,
              ),
            ),
            verticalSpaceRegular,
            RichText(
              text: TextSpan(
                  text: 'Where would you like ',
                  style: kRegularTextStyle.copyWith(
                    fontSize: 16,
                    // height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'Smartpay ',
                      style: kLargeTextStyle.copyWith(
                        fontSize: 16,
                        color: AppColor.kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'to send your security code?',
                      style: kRegularTextStyle.copyWith(
                        fontSize: 16,
                        // height: 1.5,
                      ),
                    ),
                  ]),
            ),
            verticalSpaceMedium,
            ListTile(
              tileColor: AppColor.kGreyNeutral.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              leading: const Icon(
                Icons.check_circle,
                color: AppColor.kPrimaryColor,
              ),
              title: Text(
                "Email",
                style: kLargeTextStyle.copyWith(fontSize: 16),
              ),
              subtitle: Text(
                "m*****@gmail.com",
                style: kRegularTextStyle.copyWith(fontSize: 12),
              ),
              trailing: Icon(Icons.email_outlined,
                  color: AppColor.kGreyNeutral.shade400),
            ),
            const Spacer(),
            SPFlatButton(
              pressState: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const CreateNewPasswordScreen();
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
