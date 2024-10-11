import 'dart:convert';

class Pendingmodel {
  final String? status;
  final String? message;
  final List<Datapending>? data;

  Pendingmodel({
    this.status,
    this.message,
    this.data,
  });

  factory Pendingmodel.fromJson(String str) =>
      Pendingmodel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pendingmodel.fromMap(Map<String, dynamic> json) => Pendingmodel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datapending>.from(
                json["data"]!.map((x) => Datapending.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datapending {
  final int? id;
  final int? userId;
  final String? nama;
  final int? nomor;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datapending({
    this.id,
    this.userId,
    this.nama,
    this.nomor,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datapending.fromJson(String str) =>
      Datapending.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datapending.fromMap(Map<String, dynamic> json) => Datapending(
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
