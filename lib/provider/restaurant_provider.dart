import 'package:restaurant_app_state/api/api_service.dart';
import 'package:restaurant_app_state/model/restaurant.dart';
import 'package:flutter/foundation.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurants();
  }

  late RestaurantResult _result;
  late ResultState _state;
  String _message = '';

  RestaurantResult get result => _result;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getList();
      if (response.restaurants.isEmpty) {
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _result = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "$e";
    }
  }
}
