import 'package:flutter/material.dart';
import 'package:restaurant_app_state/common/styles.dart';
import 'package:restaurant_app_state/provider/restaurant_provider.dart';

class BoxSearch extends StatelessWidget {
  final RestaurantProvider provider;

  const BoxSearch({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: TextFormField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            provider.onSearch(value);
          } else if (value.isEmpty) {
            provider.onSearch(" ");
          }
        },
        style: blackTextStyle.copyWith(
          fontSize: 14,
          fontWeight: semiBold,
          letterSpacing: 1.2,
        ),
        decoration: InputDecoration(
          hintText: 'Search Restaurant...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
