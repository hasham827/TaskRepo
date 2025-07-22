import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnack(String message, {bool isSuccess = false}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    "",
    "",
    barBlur: 0,
    overlayBlur: 0,
    duration: Duration(seconds: 1),
    backgroundColor: Colors.transparent,
    overlayColor: Colors.transparent,
    titleText: Container(
      padding: EdgeInsets.only(left: 5, right: 0.1, top: 0.1, bottom: 1),
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              isSuccess
                  ? Icons.check_circle_outline_outlined
                  : Icons.error_outline_rounded,
              color: isSuccess ? Colors.green : Colors.red,
            ),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
  );
}
