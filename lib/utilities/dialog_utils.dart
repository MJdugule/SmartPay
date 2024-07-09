import 'package:flutter/material.dart';
import 'package:smartpay/res/widget/dialog.dart';

class DialogUtilities {
  DialogUtilities();

  showForgotPinDialog(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => const SPForgotPinDialog());
  }
}
