import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_state/api/api_service.dart';
import 'package:restaurant_app_state/common/styles.dart';
import 'package:restaurant_app_state/model/restaurant_detail.dart';
import 'package:restaurant_app_state/provider/restaurant_provider.dart';
import 'package:restaurant_app_state/widget/menu_item.dart';
import 'package:restaurant_app_state/widget/response_widget.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantProvider provider = RestaurantProvider(apiService: ApiService());
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) {
        return provider.getRestaurant(id);
      },
      child: Scaffold(
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return detailScreen(
                context,
                state.detail.restaurant,
                provider,
              );
            } else if (state.state == ResultState.error) {
              return noInternetWidget(state.message);
            } else {
              return emptyDataWidget(state.message);
            }
          },
        ),
      ),
    );
  }

  detailScreen(
    BuildContext context,
    Restaurant restaurant,
    RestaurantProvider provider,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: restaurant.id,
                child: Image.network(restaurant.getMediumPicture()),
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() => Navigator.pop(context)),
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                        ),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kPrimaryColor,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        letterSpacing: 1.5,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/icon_star.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: kGreyColor,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        restaurant.city,
                        style: greyTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  margin: const EdgeInsets.only(
                    top: 16,
                    bottom: 10,
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Description',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                    style: blackTextStyle.copyWith(
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Menu',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          letterSpacing: 1.5,
                          fontWeight: semiBold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Foods :',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          letterSpacing: 1.5,
                          fontWeight: medium,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 0.06),
                  width: (MediaQuery.of(context).size.width * 0.94),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.menus.foods
                        .map((foods) => menuItem(foods.name))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Drinks :',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          letterSpacing: 1.5,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 0.06),
                  width: (MediaQuery.of(context).size.width * 0.94),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.menus.drinks
                        .map((drinks) => menuItem(drinks.name))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
