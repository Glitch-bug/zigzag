// To parse this JSON data, do
//
//     final paymentGetway = paymentGetwayFromJson(jsonString);

import 'dart:convert';

PaymentGetway paymentGetwayFromJson(String str) => PaymentGetway.fromJson(json.decode(str));

String paymentGetwayToJson(PaymentGetway data) => json.encode(data.toJson());

class PaymentGetway {
  List<Paymentdatum> paymentdata;
  String responseCode;
  String result;
  String responseMsg;

  PaymentGetway({
    required this.paymentdata,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory PaymentGetway.fromJson(Map<String, dynamic> json) => PaymentGetway(
    paymentdata: List<Paymentdatum>.from(json["paymentdata"].map((x) => Paymentdatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "paymentdata": List<dynamic>.from(paymentdata.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class Paymentdatum {
  String id;
  String title;
  String img;
  String attributes;
  String status;
  String subtitle;
  String pShow;

  Paymentdatum({
    required this.id,
    required this.title,
    required this.img,
    required this.attributes,
    required this.status,
    required this.subtitle,
    required this.pShow,
  });

  factory Paymentdatum.fromJson(Map<String, dynamic> json) => Paymentdatum(
    id: json["id"],
    title: json["title"],
    img: json["img"],
    attributes: json["attributes"],
    status: json["status"],
    subtitle: json["subtitle"],
    pShow: json["p_show"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "img": img,
    "attributes": attributes,
    "status": status,
    "subtitle": subtitle,
    "p_show": pShow,
  };
}
