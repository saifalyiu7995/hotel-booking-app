// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
    this.firstname,
    this.lastname,
    this.gender,
    this.dob,
    this.email,
    this.countryId,
    this.stateId,
    this.cityId,
    this.address,
    this.mobile,
    this.idType,
    this.idNo,
    this.idUpload,
    this.remark,
    this.vip,
  });

  String id;
  String firstname;
  String lastname;
  String gender;
  String dob;
  String email;
  String countryId;
  String stateId;
  String cityId;
  String address;
  String mobile;
  dynamic idType;
  String idNo;
  dynamic idUpload;
  String remark;
  String vip;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        gender: json["gender"],
        dob: json["dob"],
        email: json["email"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        address: json["address"],
        mobile: json["mobile"],
        idType: json["id_type"],
        idNo: json["id_no"],
        idUpload: json["id_upload"],
        remark: json["remark"],
        vip: json["vip"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "dob": dob,
        "email": email,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "address": address,
        "mobile": mobile,
        "id_type": idType,
        "id_no": idNo,
        "id_upload": idUpload,
        "remark": remark,
        "vip": vip,
      };
}
