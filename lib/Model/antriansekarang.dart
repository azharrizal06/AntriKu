import 'dart:convert';

class AntrianSekarang {
  final String? status;
  final String? message;
  final DataAntrianSekarang? antrian;

  AntrianSekarang({
    this.status,
    this.message,
    this.antrian,
  });

  factory AntrianSekarang.fromJson(String str) =>
      AntrianSekarang.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AntrianSekarang.fromMap(Map<String, dynamic> json) => AntrianSekarang(
        status: json["status"],
        message: json["message"],
        antrian: json["antrian"] == null
            ? null
            : DataAntrianSekarang.fromMap(json["antrian"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "antrian": antrian?.toMap(),
      };
}

class DataAntrianSekarang {
  final int? id;
  final int? userId;
  final String? nama;
  final int? nomor;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataAntrianSekarang({
    this.id,
    this.userId,
    this.nama,
    this.nomor,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DataAntrianSekarang.fromJson(String str) =>
      DataAntrianSekarang.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAntrianSekarang.fromMap(Map<String, dynamic> json) =>
      DataAntrianSekarang(
        id: json["id"],
        userId: json["user_id"],
        nama: json["nama"],
        nomor: json["nomor"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "nama": nama,
        "nomor": nomor,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
