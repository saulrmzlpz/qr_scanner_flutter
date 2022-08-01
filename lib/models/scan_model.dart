import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

enum QrType { http, geo }

class ScanModel {
  ScanModel({
    this.id,
    this.tipo = QrType.http,
    required this.valor,
  }) {
    tipo = valor.contains('http') ? QrType.http : QrType.geo;
  }

  int? id;
  QrType tipo;
  String valor;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo.name,
        "valor": valor,
      };

  LatLng? getLanLng() {
    if (tipo == QrType.geo) {
      final latLng = valor.substring(4).split(',');
      final lat = double.parse(latLng[0]);
      final lng = double.parse(latLng[1]);
      return LatLng(lat, lng);
    }
    return null;
  }
}
