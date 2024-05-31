import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_starter/constants.dart';
import 'package:flutter_starter/models/user_model.dart';
import 'package:flutter_starter/shared/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService extends ChangeNotifier {
  bool? isLoggedIn;
  UserModel? connectedUser;
  String? authUserId;

  final storage = FlutterSecureStorage();

  Future<CustomSnackBar> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(Constants.uriAuthentification),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Si le serveur retourne une réponse OK, parsez le token JWT.
      isLoggedIn = true;
      var jsonResponse = jsonDecode(response.body);
      String token = jsonResponse['access_token'];
      await storage.write(key: 'jwt_token', value: token);

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // Extract the information from the payload
      String? authUserId = decodedToken['sub'];

      connectedUser = await _getUser(authUserId!, token);
      notifyListeners();

      return CustomSnackBar(
        level: "success",
        message: "Connexion réussie",
      );
    } else {
      isLoggedIn = false;
      notifyListeners();
      // Si la réponse n'est pas OK, lancez une exception.
      throw Exception('Failed to login');
    }
  }

  void logout() async {
    await storage.delete(key: 'jwt_token');
    isLoggedIn = false;
    notifyListeners();
  }

  Future<UserModel?> _getUser(String authUserId, String token) async {
    final response = await http.get(
      Uri.parse('${Constants.uriUsers}/$authUserId'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      return UserModel.fromJson(userData);
    } else {
      throw Exception('Failed to load user');
    }

    // Map<String, dynamic> body = jsonDecode(response.body);

    // if (body.containsKey("data")) {
    //   List<dynamic> userData = body["data"];
    //   if (userData.isNotEmpty) {
    //     return UserModel.fromJson(userData[0]);
    //   }
    // }
    // return null;
  }
}
