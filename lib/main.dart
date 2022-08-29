import 'package:flutter/material.dart';
import 'package:restaurant_app_state/ui/restaurant_detail_page.dart';
import 'package:restaurant_app_state/ui/restaurant_list_page.dart';
import 'package:restaurant_app_state/ui/restaurant_search_page.dart';
import 'package:restaurant_app_state/ui/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => const SplashScreenPage(),
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantSearchPage.routeName: (context) =>
            const RestaurantSearchPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
