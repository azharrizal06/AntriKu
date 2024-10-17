import 'dart:convert';

class CreateAntri {
  final String? status;
  final String? message;
  final int? nomor;
  final DataAntriUser? data;

  CreateAntri({
    this.status,
    this.message,
    this.nomor,
    this.data,
  });

  factory CreateAntri.fromJson(String str) =>
      CreateAntri.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateAntri.fromMap(Map<String, dynamic> json) => CreateAntri(
        status: json["status"],
        message: json["message"],
        nomor: json["nomor"],
        data: json["Data"] == null ? null : DataAntriUser.fromMap(json["Data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "nomor": nomor,
        "Data": data?.toMap(),
      };
}

class DataAntriUser {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataAntriUser({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory DataAntriUser.fromJson(String str) =>
      DataAntriUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAntriUser.fromMap(Map<String, dynamic> json) => DataAntriUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
