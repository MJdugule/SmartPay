import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';

class SPForgotPinDialog extends StatelessWidget {
  const SPForgotPinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        elevation: 0.0,
        child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("How can we help?",
                    textAlign: TextAlign.center,
                    style: kLargeTextStyle.copyWith(fontSize: 19, fontWeight: FontWeight.w500)),
                verticalSpaceRegular,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () =>{},
                      child: Column(children: [
                        Text(
                          "Reset Pin",
                          style: kLargeTextStyle.copyWith(color: AppColor.kPrimaryColor, fontSize: 18),
                        )
                      ]),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: Column(children: [
                        Text(
                          "Sign out",
                          style: kLargeTextStyle.copyWith(color: AppColor.kPrimaryColor, fontSize: 18),
                        )
                      ]),
                    ), 
                    horizontalSpaceSmall,
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Column(children: [
                        Text(
                          "Cancel",
                          style: kLargeTextStyle.copyWith(color: AppColor.kPrimaryColor, fontSize: 17),
                        )
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
