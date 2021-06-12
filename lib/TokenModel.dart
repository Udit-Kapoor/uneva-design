// To parse this JSON data, do
//
//     final tokensModel = tokensModelFromJson(jsonString);

import 'dart:convert';

import 'api_helper.dart';
import 'api_response.dart';

List<TokensModel> tokensModelFromJson(String str) => List<TokensModel>.from(
    json.decode(str).map((x) => TokensModel.fromJson(x)));

String tokensModelToJson(List<TokensModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TokensModel {
  TokensModel({
    this.objectId,
    this.other,
    this.name,
    this.f,
    this.queueType,
    this.description,
    this.externalReference,
    this.timestamp,
    this.status,
    this.tokenName,
    this.originalTokenNumber,
    this.tokenNumber,
    this.scheduled,
    this.createdAt,
    this.updatedAt,
    this.doneTime,
  });

  String objectId;
  Other other;
  String name;
  int f;
  QueueType queueType;
  String description;
  String externalReference;
  int timestamp;
  int status;
  String tokenName;
  int originalTokenNumber;
  int tokenNumber;
  bool scheduled;
  DateTime createdAt;
  DateTime updatedAt;
  int doneTime;

  factory TokensModel.fromJson(Map<String, dynamic> json) => TokensModel(
        objectId: json["objectId"],
        other: Other.fromJson(json["other"]),
        name: json["name"],
        f: json["f"],
        queueType: QueueType.fromJson(json["queueType"]),
        description: json["description"],
        externalReference: json["externalReference"],
        timestamp: json["timestamp"],
        status: json["status"],
        tokenName: json["tokenName"],
        originalTokenNumber: json["originalTokenNumber"],
        tokenNumber: json["tokenNumber"],
        scheduled: json["scheduled"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        doneTime: json["doneTime"] == null ? null : json["doneTime"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "other": other.toJson(),
        "name": name,
        "f": f,
        "queueType": queueType.toJson(),
        "description": description,
        "externalReference": externalReference,
        "timestamp": timestamp,
        "status": status,
        "tokenName": tokenName,
        "originalTokenNumber": originalTokenNumber,
        "tokenNumber": tokenNumber,
        "scheduled": scheduled,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "doneTime": doneTime == null ? null : doneTime,
      };
}

class Other {
  Other({
    this.pid,
  });

  int pid;

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        pid: json["pid"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
      };
}

class QueueType {
  QueueType({
    this.type,
    this.className,
    this.objectId,
  });

  String type;
  String className;
  String objectId;

  factory QueueType.fromJson(Map<String, dynamic> json) => QueueType(
        type: json["__type"],
        className: json["className"],
        objectId: json["objectId"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "className": className,
        "objectId": objectId,
      };
}

Future<ApiResponse> getItems() async {
  ApiResponse cp = await ApiHelper().getReq(
    endpoint: "https://dev.uneva.in/task_721/list.php",
  );
  return cp;
}
