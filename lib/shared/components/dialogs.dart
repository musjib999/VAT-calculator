import 'package:flutter/material.dart';

import '../themes/themes.dart';
import 'buttons.dart';

enum Status { success, error, noInternet }

extension StatusX on Status {
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
  bool get isNoInternet => this == Status.noInternet;
}

void showSnackbar(
  BuildContext context,
  Status status, {
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width:
          MediaQuery.of(context).size.width > 600
              ? MediaQuery.of(context).size.width * 0.25
              : double.infinity,
      backgroundColor: status.isSuccess ? AppColors.success : AppColors.error,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            status.isNoInternet
                ? Icons.wifi_off
                : status.isError
                ? Icons.error
                : Icons.check_circle,
            color: AppColors.white,
          ),
          Expanded(child: Text(message)),
        ],
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    return picked;
  } else {
    return null;
  }
}

Future<TimeOfDay?> selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) {
    return picked;
  } else {
    return null;
  }
}

void showPopUpDialog(BuildContext context, {required Widget child}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(child: child);
    },
  );
}

void showInformationPopUp(
  BuildContext context, {
  required String title,
  required String info,
  required void Function()? onYes,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(info),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No', style: TextStyle(color: AppColors.primaryColor)),
          ),
          TextButton(
            onPressed: onYes,
            child: Text('Yes', style: TextStyle(color: AppColors.primaryColor)),
          ),
        ],
      );
    },
  );
}

void showActionDialog(
  BuildContext context, {
  required String title,
  required String message,
  required IconData icon,
  required void Function()? onContinue,
  Color? color,
}) {
  final screenSize = MediaQuery.of(context).size;
  showPopUpDialog(
    context,
    child: Container(
      width: screenSize.width < 800 ? null : screenSize.width * 0.37,
      height:
          screenSize.width < 800
              ? screenSize.height * 0.58
              : screenSize.height * 0.78,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height:
                screenSize.width < 800
                    ? screenSize.width * 0.30
                    : screenSize.width * 0.20,
            width:
                screenSize.width < 800
                    ? screenSize.height * 0.30
                    : screenSize.height * 0.20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: color ?? AppColors.primaryColor,
                width: 5,
              ),
            ),
            child: Icon(
              icon,
              size:
                  screenSize.width < 800
                      ? screenSize.width * 0.16
                      : screenSize.width * 0.06,
              color: color ?? AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTextStyle.title.copyWith(
              color: color ?? AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.headline.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            width:
                screenSize.width < 800
                    ? screenSize.width * 0.70
                    : screenSize.width * 0.30,
            text: 'Continue',
            onPressed: onContinue,
          ),
        ],
      ),
    ),
  );
}

void showLogoutDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: Center(child: Text('Log out', style: AppTextStyle.label)),
        content: Text(
          'Are you sure you want to log out?',
          style: AppTextStyle.body,
        ),
        actions: <Widget>[
          PrimaryButton(
            text: 'Cancel',
            onPressed: () => Navigator.pop(context),
            bgColor: AppColors.lighterPrimaryColor,
            buttonTextStyle: AppTextStyle.label.copyWith(
              color: AppColors.primaryColor,
            ),
            width: 110,
          ),
          PrimaryButton(
            text: 'Okay',
            onPressed: onConfirm,
            bgColor: AppColors.primaryColor,
            buttonTextStyle: AppTextStyle.label.copyWith(
              color: AppColors.white,
            ),
            width: 110,
          ),
        ],
      );
    },
  );
}

bool validateEmail(String email) {
  String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

String? validateTextField(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field is required';
  } else {
    return null;
  }
}

String convertPhoneNumberToInternationalStandard(String phone) {
  String code = '+234';
  String cleanedPhone = phone.replaceAll(RegExp(r'\s|-'), '');

  if (cleanedPhone.startsWith('0') && cleanedPhone.length == 11) {
    return code + cleanedPhone.substring(1);
  } else {
    throw 'This phone number is not a valid Nigerian phone number';
  }
}

CircularProgressIndicator loader(Color color) {
  return CircularProgressIndicator(color: color);
}

