import 'dart:convert';

class GetantriUser {
  final String? status;
  final String? message;
  final List<DataAntriUser>? data;

  GetantriUser({
    this.status,
    this.message,
    this.data,
  });

  factory GetantriUser.fromJson(String str) =>
      GetantriUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetantriUser.fromMap(Map<String, dynamic> json) => GetantriUser(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataAntriUser>.from(
                json["data"]!.map((x) => DataAntriUser.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class DataAntriUser {
  final int? id;
  final int? userId;
  final String? nama;
  final int? nomor;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataAntriUser({
    this.id,
    this.userId,
    this.nama,
    this.nomor,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DataAntriUser.fromJson(String str) =>
      DataAntriUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAntriUser.fromMap(Map<String, dynamic> json) => DataAntriUser(
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
