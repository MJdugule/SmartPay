import 'package:flutter/material.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/main.dart';

enum SNACKBARTYPE { error, warning, info, success }

class SPSnackBarUtilities {
  SPSnackBarUtilities();

  showSnackBar({required String message, required SNACKBARTYPE snackbarType}) {
    scaffoldKey.currentState!.hideCurrentSnackBar();
    // IconData icon = FontAwesomeIcons.ban;
    Color color = AppColor.kErrorColor;

    if (SNACKBARTYPE.warning == snackbarType) {
      // icon = FontAwesomeIcons.circleExclamation;
      color = kOrange;
    } else if (SNACKBARTYPE.info == snackbarType) {
      color = kBlue;
    } else if (SNACKBARTYPE.success == snackbarType) {
      color = kGreen;
    }
    scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: color.withOpacity(0.9),
        content:
            // SnackBarWidget(message),
            Text(
          message,
          style: kFormHeaderTextStyle.copyWith(color: kWhite, fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        duration: const Duration(seconds: 4),
        elevation: 6.0,
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        // padding: EdgeInsets.only(bottom: 200),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
