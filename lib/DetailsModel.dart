// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

import 'api_helper.dart';
import 'api_response.dart';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  DetailsModel({
    this.personFullName,
    this.personGender,
    this.personPic,
    this.personAge,
    this.personPhone,
    this.personPid,
    this.personRelation,
    this.personAddress,
    this.personOccupation,
    this.personCaption,
    this.pk,
  });

  String personFullName;
  String personGender;
  String personPic;
  String personAge;
  String personPhone;
  String personPid;
  String personRelation;
  String personAddress;
  dynamic personOccupation;
  String personCaption;
  int pk;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        personFullName: json["person_full_name"],
        personGender: json["person_gender"],
        personPic: json["person_pic"],
        personAge: json["person_age"],
        personPhone: json["person_phone"],
        personPid: json["person_pid"],
        personRelation: json["person_relation"],
        personAddress: json["person_address"],
        personOccupation: json["person_occupation"],
        personCaption: json["person_caption"],
        pk: json["_pk"],
      );

  Map<String, dynamic> toJson() => {
        "person_full_name": personFullName,
        "person_gender": personGender,
        "person_pic": personPic,
        "person_age": personAge,
        "person_phone": personPhone,
        "person_pid": personPid,
        "person_relation": personRelation,
        "person_address": personAddress,
        "person_occupation": personOccupation,
        "person_caption": personCaption,
        "_pk": pk,
      };
}

Future<ApiResponse> getDetails(String query) async {
  ApiResponse cp = await ApiHelper().getReq(
    endpoint: "https://dev.uneva.in/task_721/patient.php?id=",
    query: query,
  );
  return cp;
}
