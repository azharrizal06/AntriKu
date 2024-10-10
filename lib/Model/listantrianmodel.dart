import 'dart:convert';

class AwaitingAntrian {
  final String? status;
  final String? mwssage;
  final List<Antrian>? data;

  AwaitingAntrian({
    this.status,
    this.mwssage,
    this.data,
  });

  factory AwaitingAntrian.fromJson(String str) =>
      AwaitingAntrian.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AwaitingAntrian.fromMap(Map<String, dynamic> json) => AwaitingAntrian(
        status: json["status"],
        mwssage: json["mwssage"],
        data: json["Data"] == null
            ? []
            : List<Antrian>.from(json["Data"]!.map((x) => Antrian.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "mwssage": mwssage,
        "Data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Antrian {
  final int? id;
  final int? userId;
  final String? nama;
  final int? nomor;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Antrian({
    this.id,
    this.userId,
    this.nama,
    this.nomor,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Antrian.fromJson(String str) => Antrian.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Antrian.fromMap(Map<String, dynamic> json) => Antrian(
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
