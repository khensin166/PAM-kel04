// To parse this JSON data, do
//
//     final mahasiswaModel = mahasiswaModelFromJson(jsonString);

import 'dart:convert';

MahasiswaModel mahasiswaModelFromJson(String str) => MahasiswaModel.fromJson(json.decode(str));

String mahasiswaModelToJson(MahasiswaModel data) => json.encode(data.toJson());

class MahasiswaModel {
    int? id;
    String? ktp;
    String? nim;
    String? nama;
    String? handphone;
    String? email;
    dynamic? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    MahasiswaModel({
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

    factory MahasiswaModel.fromJson(Map<String, dynamic> json) => MahasiswaModel(
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
