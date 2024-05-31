// import 'package:flutter_starter/services/auth_service.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class UserService {
//   final AuthService authService;
//   final FlutterSecureStorage storage;

//   UserService({required this.authService, required this.storage});

//   Future<void> retrieveTokenAndDecode() async {
//     // Retrieve the token from storage
//     String? token = await storage.read(key: 'jwt_token');

//     if (token != null) {
//       // Decode the token
//       Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

//       // Extract the information from the payload
//       String? userId = decodedToken['userId'];
//       String? role = decodedToken['role'];

//       // Use the extracted information
//       print('User ID: $userId');
//       print('Role: $role');
//     } else {
//       print('Token not found in storage');
//     }
//   }
// }
