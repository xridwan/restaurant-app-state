import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_state/api/api_service.dart';
import 'package:restaurant_app_state/common/styles.dart';
import 'package:restaurant_app_state/provider/restaurant_provider.dart';
import 'package:restaurant_app_state/ui/restaurant_search_page.dart';
import 'package:restaurant_app_state/widget/response_widget.dart';
import 'package:restaurant_app_state/widget/restaurant_item.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantItem(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.error) {
          return noInternetWidget(state.message);
        } else {
          return emptyDataWidget(state.message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
            icon: Icon(
              Icons.search_sharp,
              color: kBlackColor,
            ),
          ),
        ],
        title: Text(
          'Restaurant App',
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 0,
      ),
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (context) {
          RestaurantProvider provider =
              RestaurantProvider(apiService: ApiService());
          return (provider.getRestaurants());
        },
        child: _buildList(),
      ),
    );
  }
}
