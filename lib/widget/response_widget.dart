import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app_state/common/styles.dart';

Widget noInternetWidget(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        'assets/no_internet.json',
        width: 250,
        height: 250,
      ),
      const SizedBox(height: 8),
      Text(
        message,
        style: blackTextStyle.copyWith(
          fontSize: 24,
          fontWeight: semiBold,
        ),
      ),
    ],
  );
}

Widget emptyDataWidget(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        'assets/empty_data.json',
        width: 250,
        height: 250,
      ),
      const SizedBox(height: 8),
      Text(
        message,
        style: blackTextStyle.copyWith(
          fontSize: 24,
          fontWeight: semiBold,
        ),
      ),
    ],
  );
}
