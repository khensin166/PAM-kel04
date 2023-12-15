// To parse this JSON data, do
//
//     final izinBermalamModel = izinBermalamModelFromJson(jsonString);

import 'dart:convert';

IzinBermalamModel izinBermalamModelFromJson(String str) =>
    IzinBermalamModel.fromJson(json.decode(str));

String izinBermalamModelToJson(IzinBermalamModel data) =>
    json.encode(data.toJson());

class IzinBermalamModel {
  String? keterangan;
  DateTime? rencanaBerangkat;
  DateTime? rencanaKembali;
  String? tujuan;
  String? status;
  int? mahasiswaId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  IzinBermalamModel({
    this.keterangan,
    this.rencanaBerangkat,
    this.rencanaKembali,
    this.tujuan,
    this.status,
    this.mahasiswaId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory IzinBermalamModel.fromJson(Map<String, dynamic> json) =>
      IzinBermalamModel(
        keterangan: json["keterangan"],
        rencanaBerangkat: DateTime.parse(json["rencana_berangkat"]),
        rencanaKembali: DateTime.parse(json["rencana_kembali"]),
        tujuan: json["tujuan"],
        status: json["status"],
        mahasiswaId: json["mahasiswa_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "keterangan": keterangan,
        "rencana_berangkat": rencanaBerangkat!.toIso8601String(),
        "rencana_kembali": rencanaKembali!.toIso8601String(),
        "tujuan": tujuan,
        "status": status,
        "mahasiswa_id": mahasiswaId,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}
