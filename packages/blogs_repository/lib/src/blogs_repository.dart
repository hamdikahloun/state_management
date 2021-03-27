import 'dart:async';
import 'dart:convert';

import 'package:blogs_repository/src/models/models.dart';
import 'package:http/http.dart' as http;

class BlogRepository {
  static final BlogRepository _singleton = BlogRepository._internal();

  /// Blog Repository
  ///
  /// The Constructor should include the token fetched in (authenticate) request.
  factory BlogRepository({required token}) {
    _singleton.token = token;
    return _singleton;
  }

  BlogRepository._internal();

  final http.Client httpClient = http.Client();
  String? token;
  final String _baseUrl = '60585b2ec3f49200173adcec.mockapi.io';

  /// Fetch a list of blogs
  ///
  /// Can throw a [Exception].
  Future<List<Item>> getBlogs() async {
    final response = await httpClient.get(
        Uri.https(
          _baseUrl,
          '/api/v1/blogs',
        ),
        headers: {'Authorization': 'Bearer $token'});
    if (token == null) {
      throw Exception('Fetch list of blogs with Bearer $token');
    }
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map<Item>((dynamic json) {
        return Item.fromJson(json as Map<String, dynamic>);
      }).toList();
    }
    throw Exception('error fetching items');
  }

  /// Fetch a single blog by id
  ///
  /// Can throw a [Exception].
  Future<Item> getEntryBlog({required String id}) async {
    final response = await httpClient.get(
        Uri.https(
          _baseUrl,
          '/api/v1/blogs/$id',
        ),
        headers: {'Authorization': 'Bearer $token'});
    if (token == null) {
      throw Exception('Fetch blog ID $id with Bearer $token');
    }
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body) as Map<String, dynamic>);
    }
    throw Exception('error fetching item');
  }
}
