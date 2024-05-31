import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_starter/models/user_model.dart';
import 'package:flutter_starter/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../constants.dart';
import '../models/profile_model.dart';

class ProfileService {
  late UserModel connectedUser;
  late ProfileModel? profile;

  ProfileService(BuildContext context) {
    connectedUser =
        Provider.of<AuthService>(context, listen: false).connectedUser!;
  }

  Future<ProfileModel> fetchProfiles() async {
    final response = await http
        .get(Uri.parse('${Constants.uriProfiles}?userId=${connectedUser.id}'));

    inspect(response);

    if (response.statusCode == 200) {
      profile = ProfileModel.fromJson(jsonDecode(response.body));
      // return ProfileModel.fromJson(jsonDecode(response.body));
      return profile!;
    } else {
      throw Exception('Failed to load profil');
    }
  }

  Future<bool> updateProfile(ProfileModel profile) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer $token'
    };

    final response = await http.patch(
      Uri.parse('${Constants.uriUsers}/${profile.id}'),
      headers: headers,
      body: jsonEncode(profile.toJson()),
    );

    if (response.statusCode == 200) {
      print("object");
      return true;
    } else {
      print('Erreur lors de la mise à jour du profil: ${response.body}');
      return false;
    }
  }
}
