import 'dart:convert';
import 'package:flutter_bloc_structure/Model/Model.dart';
import 'package:http/http.dart';

class UserRepository {
  // String userUrl = 'https://reqres.in/api/users?page=2';
  String userUrl = 'https://reqres.in/api/users';
  Future<List<Data>> getUsers() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Data.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}