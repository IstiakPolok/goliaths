import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetController extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen to connection status changes
    InternetConnection().onStatusChange.listen((status) async {
      bool hasConnection = status == InternetStatus.connected;

      if (hasConnection != isConnected.value) {
        isConnected.value = hasConnection;

        if (!hasConnection) {
          _showNoInternetDialog();
        } else {
          // When connection returns, close the dialog automatically
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        }
      }
    });
  }

  void _showNoInternetDialog() {
    if (Get.isDialogOpen ?? false) return; // prevent multiple dialogs

    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false, // Disable back button
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          titlePadding: EdgeInsets.only(top: 20.h, bottom: 10.h),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          title: Column(
            children: [
              Icon(Icons.wifi_off, color: const Color(0xFFF9BE2D), size: 45.sp),
              SizedBox(height: 10.h),
              Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              "Please check your internet connection and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.only(bottom: 15.h),
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                bool hasInternet = await InternetConnection().hasInternetAccess;

                if (hasInternet) {
                  isConnected.value = true;
                  if (Get.isDialogOpen ?? false) {
                    Get.back(); // Close dialog
                  }
                } else {
                  // ✅ Close all previous snackbars before showing a new one
                  Get.closeAllSnackbars();

                  Get.snackbar(
                    "Still Offline",
                    "No internet connection available.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color.fromARGB(82, 255, 255, 255),
                    colorText: Colors.black,
                    margin: EdgeInsets.all(16.w),
                    duration: const Duration(seconds: 2),
                  );
                }
              },
              icon: Icon(Icons.refresh, size: 18.sp),
              label: Text(
                "Retry",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFF9BE2D),
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
