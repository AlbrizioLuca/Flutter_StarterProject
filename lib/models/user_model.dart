class UserModel {
  String? id;
  String email;
  String password;
  String? role;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"] != null ? json["id"] as String : null,
        email = json["email"] as String,
        password = json["password"] as String,
        role = json["role"] != null ? json["role"] as String : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "email": email,
      "password": password,
      "role": role,
    };

    return data;
  }
}
