import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_state/api/api_service.dart';
import 'package:restaurant_app_state/provider/restaurant_provider.dart';
import 'package:restaurant_app_state/widget/restaurant_item_search.dart';
import 'package:restaurant_app_state/widget/box_search.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiService: ApiService()).getSearch(),
        child: SafeArea(
          child: ListView(
            children: [
              Consumer<RestaurantProvider>(
                builder: (context, provider, _) {
                  return BoxSearch(
                    provider: provider,
                  );
                },
              ),
              Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.search.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.search.restaurants[index];
                        return RestaurantItemSearch(restaurant: restaurant);
                      },
                    );
                  } else if (state.state == ResultState.error) {
                    return Center(
                      child: Lottie.asset('assets/no_internet.json'),
                    );
                  } else {
                    return Center(
                      child: Lottie.asset('assets/empty_data.json'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
