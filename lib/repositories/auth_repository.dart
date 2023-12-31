// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:sample/config/app.dart';
import 'package:sample/models/user_model.dart';
import 'package:sample/services/dio.dart';
import 'package:sample/services/shared_prefs.dart';

class AuthRepository {
  final Ref ref;
  final Dio dio;

  AuthRepository({
    required this.ref,
    required this.dio,
  });

  Future<UserModel?> userDataById(String id) async {
    try {
      var url = Uri.https(BASE_URL, '/api/collections/users/records/:$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.body);
        return user;
      }  
      else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    // await Future.delayed(const Duration(seconds: 2));
    try {
      // final prefs = await ref.read(sharedPrefsProvider.future);
      // String? token = prefs.getString('token');
      // String? id = prefs.getString('id');

      // if (id == null || token == null) return null;

      // dio.options.headers['Authorization'] = "Bearer $token";
      // Response response = await dio.get('/api/odata/ApplicationUser($id)');

      // UserModel user = UserModel.fromMap(response.data);

      UserModel user = UserModel(Oid: 'Oid', Ten: 'Việt Hùng');

      return user;
      
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel?> signInWithPassword(String identity, String password, bool rememberMe) async {
    try {
      // Response response = await dio.post('/api/Authentication/Authenticate', data: {
      //   "userName": identity,
      //   "password": password
      // });

      // dio.options.headers['Authorization'] = "Bearer ${response.data['token']}";

      // final prefs = await ref.read(sharedPrefsProvider.future);

      // if (rememberMe) {
      //   await prefs.setString('token', response.data['token']);
      //   await prefs.setString('id', response.data['user']['Oid']);
      //   // await prefs.setString('id', response.data['user']['oid']);
      // }
      // // await prefs.setString('landing', 'true');

      // UserModel user = UserModel.fromMap(response.data['user']);

      await Future.delayed(const Duration(seconds: 1));

      UserModel user = UserModel(Oid: 'Oid', Ten: 'Việt Hùng', DiaChiEmail: identity);

      return user;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = ref.watch(sharedPrefsProvider);
      await prefs.remove('token');
      await prefs.remove('id');

    } catch (e) {}
  }
}

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(ref: ref, dio: dio);
});