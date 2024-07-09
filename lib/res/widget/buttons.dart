import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';

class SPBackButton extends StatelessWidget {
  final VoidCallback pressState;

  const SPBackButton(
      {required this.pressState,  Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: pressState,
      child: Container(
        height: 40,
        width: 40,
        decoration:  BoxDecoration(
          color: AppColor.kWhiteColor,
          shape: BoxShape.rectangle,
          border: Border.all(color: AppColor.kGreyNeutral.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Icon(
          Icons.arrow_back_ios,
          color: AppColor.kGreyNeutral.shade600,
          size: 20,
        ),
      ),
    );
  }
}
