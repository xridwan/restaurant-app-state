import 'package:flutter/material.dart';
import 'package:restaurant_app_state/common/styles.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 55,
          margin: const EdgeInsets.all(24),
          child: TextFormField(
            onChanged: (value) {},
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
        ),
      ),
    );
  }
}
