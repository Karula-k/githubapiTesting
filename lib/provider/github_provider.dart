import 'package:flutter/cupertino.dart';
import 'package:githubapi/data/api/api.dart';
import 'package:githubapi/data/model/github.dart';

enum ResultState { Loading, NoData, HasData, Error }

class GithubProvider extends ChangeNotifier {
  final ApiService apiService;

  GithubProvider({required this.apiService}) {
    _fetchAllGithub();
  }
  late Github _githubResult;
  late ResultState _state;
  String _massage = " ";
  Future<dynamic> _fetchAllGithub() async {
    try {
      _state = ResultState.NoData;
      notifyListeners();
      final github = await apiService.userSearch();
      if (github.items.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _massage = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _githubResult = github;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _massage = 'Error--->$e';
    }
  }
}
