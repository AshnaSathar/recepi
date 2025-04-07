// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String email;
  String dob;
  String phone;
  dynamic photoUrl;

  ProfileModel({
    required this.email,
    required this.dob,
    required this.phone,
    required this.photoUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        email: json["email"],
        dob: json["dob"],
        phone: json["phone"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "dob": dob,
        "phone": phone,
        "photo_url": photoUrl,
      };
}
