import 'package:restaurant_app_state/api/api_service.dart';
import 'package:restaurant_app_state/model/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_state/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService});

  late RestaurantResult _result;
  late RestaurantDetail _detail;
  late RestaurantSearch _search;
  late ResultState _state;
  String _message = '';
  String _query = " ";

  RestaurantResult get result => _result;
  RestaurantDetail get detail => _detail;
  RestaurantSearch get search => _search;
  ResultState get state => _state;
  String get message => _message;

  RestaurantProvider getRestaurants() {
    _fetchRestaurants();
    return this;
  }

  RestaurantProvider getSearch() {
    _searchRestaurant();
    return this;
  }

  RestaurantProvider getRestaurant(String id) {
    _fetchRestaurant(id);
    return this;
  }

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
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

  Future<dynamic> _searchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getSearch(query: _query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _search = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "$e";
    }
  }

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetail(id);
      if (!response.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _detail = response;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "$e";
    }
  }

  void onSearch(String query) {
    _query = query;
    _searchRestaurant();
  }
}
