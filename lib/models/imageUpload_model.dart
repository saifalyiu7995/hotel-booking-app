// To parse this JSON data, do
//
//     final imageUploadModel = imageUploadModelFromJson(jsonString);

import 'dart:convert';

ImageUploadModel imageUploadModelFromJson(String str) =>
    ImageUploadModel.fromJson(json.decode(str));

String imageUploadModelToJson(ImageUploadModel data) =>
    json.encode(data.toJson());

class ImageUploadModel {
  ImageUploadModel({
    this.status,
    this.frontSide,
    this.message,
  });

  String status;
  String frontSide;
  String message;

  factory ImageUploadModel.fromJson(Map<String, dynamic> json) =>
      ImageUploadModel(
        status: json["status"],
        frontSide: json["front_side"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "front_side": frontSide,
        "message": message,
      };
}
