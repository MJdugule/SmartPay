

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smartpay/constants/constant.dart';
import 'package:smartpay/utilities/snackbar_utils.dart';


class InternetChecker{
   checkInternetStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
         !connectivityResult.contains(ConnectivityResult.wifi)) {
      SPSnackBarUtilities().showSnackBar(message: kInternetErrorMessage, snackbarType: SNACKBARTYPE.error);
      return;
    }

    
  }
}