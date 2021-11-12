import 'dart:convert';

import 'package:githubapi/data/model/github.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = "https://api.github.com/";
  static final _queryparam = {'q': 'karula'};
  static const _apiSearch = "search/users";
  Future<Github> userSearch() async {
    String uri = Uri(queryParameters: _queryparam).query;
    print(uri);
    var endpoint = _baseUrl + _apiSearch + "?" + uri;
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return Github.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to fetch api");
    }
  }
}
