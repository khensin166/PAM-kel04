
import 'dart:convert';

IzinKeluarModel izinKeluarModelFromJson(String str) =>
    IzinKeluarModel.fromJson(json.decode(str));

String izinKeluarModelToJson(IzinKeluarModel data) =>
    json.encode(data.toJson());

class IzinKeluarModel {
  int? id;
  int? mahasiswaId;
  DateTime? berangkat;
  DateTime? kembali;
  String? keterangan;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Mahasiswa? mahasiswa;

  IzinKeluarModel({
    this.id,
    this.mahasiswaId,
    this.berangkat,
    this.kembali,
    this.keterangan,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mahasiswa,
  });

  factory IzinKeluarModel.fromJson(Map<String, dynamic> json) =>
      IzinKeluarModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        berangkat: DateTime.parse(json["berangkat"]),
        kembali: DateTime.parse(json["kembali"]),
        keterangan: json["keterangan"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mahasiswa: Mahasiswa.fromJson(json["mahasiswa"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "berangkat": berangkat!.toIso8601String(),
        "kembali": kembali!.toIso8601String(),
        "keterangan": keterangan,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "mahasiswa": mahasiswa!.toJson(),
      };
}

class Mahasiswa {
  int? id;
  String? ktp;
  String? nim;
  String? nama;
  String? handphone;
  String? email;
  dynamic? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Mahasiswa({
    this.id,
    this.ktp,
    this.nim,
    this.nama,
    this.handphone,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        id: json["id"],
        ktp: json["ktp"],
        nim: json["nim"],
        nama: json["nama"],
        handphone: json["handphone"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ktp": ktp,
        "nim": nim,
        "nama": nama,
        "handphone": handphone,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
