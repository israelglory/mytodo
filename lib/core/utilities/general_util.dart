import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

import '../cores.dart';

final defaultPinTheme = PinTheme(
  width: 66,
  height: 66,
  textStyle: const TextStyle(
    fontSize: 22,
    color: Color.fromRGBO(30, 60, 87, 1),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    border: Border.all(color: AppColors.appGrey),
  ),
);

void handleDeviceError(dynamic error, [StackTrace? stackTrace]) {
  String errorMessage;

  // Customize error messages based on the type of error.
  switch (error) {
    case FormatException():
      log(stackTrace.toString());
      errorMessage = "Invalid data format. Please check your input.";
    case TimeoutException():
      log(stackTrace.toString());
      errorMessage = "Operation timed out. Please try again later.";
    case NoSuchMethodError():
      log(stackTrace.toString());
      errorMessage =
          "Unexpected error occurred due to a missing method or null value.";
    case TypeError():
      log(stackTrace.toString());
      errorMessage = "A type error occurred. Please verify your data types.";
    default:
      log(stackTrace.toString());
      errorMessage = 'Something Went Wrong!';
  }
  snackbarService.error(message: errorMessage);
}

String formatPhoneNumber(String phoneNumber) {
  // Remove any non-digit characters from the input
  phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // Check if the phone number starts with '0'
  if (phoneNumber.startsWith('0')) {
    phoneNumber = '+234${phoneNumber.substring(1)}';
  } else if (phoneNumber.length == 10) {
    // Check if the phone number has 10 digits
    phoneNumber = '+234$phoneNumber';
  } else {
    // If the input does not match expected formats, return the original input
    return phoneNumber;
  }

  return phoneNumber;
}

String formatAmount(String amount) {
  // Add a try and catch block to handle any potential errors
  try {
    final numAmount = double.parse(amount);
    return NumberFormat.currency(
      locale: 'en_NG',
      symbol: "\u{20A6}",
      decimalDigits: 0,
    ).format(numAmount);
  } catch (e) {
    log(e.toString());
    return '₦0';
  }
}

class DateFormatter {
  static String formatToDisplayTime(String isoDateString) {
    try {
      // Parse the ISO date string
      DateTime dateTime = DateTime.parse(isoDateString);

      // Convert to local time
      DateTime localDateTime = dateTime.toLocal();

      // Format time in 24-hour format (HH:mm)
      String timeFormat = DateFormat('HH:mm').format(localDateTime);

      // Format date as "MMM d, yyyy" (e.g., "Feb 27, 2025")
      String dateFormat = DateFormat('MMM d, yyyy').format(localDateTime);

      // Return in format "21:30, Feb 27, 2025"
      return "$timeFormat, $dateFormat";
    } catch (e) {
      return isoDateString; // Fallback to original string
    }
  }
}
