// ignore_for_file: non_constant_identifier_names

class ProfileModel {
  int id;
  String? gender;
  String? firstname;
  String? lastname;
  String? phone;
  String? birthday;
  String? profession;
  String? family_situation;

  ProfileModel({
    required this.id,
    required this.gender,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.birthday,
    required this.profession,
    required this.family_situation,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        gender = json['gender'] as String,
        firstname = json['firstname'] as String,
        lastname = json['lastname'] as String,
        phone = json['phone'] as String,
        birthday = json['birthday'] as String?,
        family_situation = json['family_situation'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "gender": gender,
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "birthday": birthday,
      "profession": profession,
      "family_situation": family_situation,
    };

    return data;
  }
}
