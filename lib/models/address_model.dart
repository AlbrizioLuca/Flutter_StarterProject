// ignore_for_file: non_constant_identifier_names

class AddressModel {
  int id;
  String? street_number;
  String? street_type;
  String? street_name;
  String? additional_info;
  String? city;
  String? postal_code;
  String? department;
  String? region;
  String? country;

  AddressModel({
    required this.id,
    required this.street_number,
    required this.street_type,
    required this.street_name,
    required this.additional_info,
    required this.city,
    required this.postal_code,
    required this.department,
    required this.region,
    required this.country,
  });

  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        street_number = json['street_number'] as String,
        street_type = json['street_type'] as String,
        street_name = json['street_name'] as String,
        additional_info = json['additional_info'] as String,
        city = json['city'] as String?,
        department = json['department'] as String?,
        region = json['region'] as String?,
        country = json['country'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "street_number": street_number,
      "street_type": street_type,
      "street_name": street_name,
      "additional_info": additional_info,
      "city": city,
      "postal_code": postal_code,
      "department": department,
      "region": region,
      "country": country,
    };

    return data;
  }
}
