import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpay/constants/constant.dart';

class SPFlatButton extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback? pressState;
  final Color textColor, buttonColor;

  const SPFlatButton(
      {this.text = "",
      required this.pressState,
      required this.active,
      required this.textColor,
      required this.buttonColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: TextButton(
            onPressed: pressState,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingMM, horizontal: kPaddingMM),
              backgroundColor: active
                  ? buttonColor
                  : AppColor.kGreyNeutral.shade700,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kPaddingSS)),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColor.kWhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )),
      ),
    );
  }
}

class SPSocialFlatButton extends StatelessWidget {
 
  
  final VoidCallback? pressState;
  final Color  buttonColor;
  final String asset;

  const SPSocialFlatButton(
      {
      required this.pressState,
      
      required this.buttonColor,
      Key? key, required this.asset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: TextButton(
            onPressed: pressState,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingMM, horizontal: kPaddingMM),
              backgroundColor: AppColor.kGreyNeutral.shade50.withOpacity(.5),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColor.kGreyNeutral.shade200),
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: SvgPicture.asset(asset)),
      ),
    );
  }
}


