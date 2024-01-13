import 'package:cloud_firestore/cloud_firestore.dart';

class SuratIzinSkripsiModel {
  String nama;
  String npm;
  String tempatLahir;
  DateTime tanggalLahir;
  String jenisSurat;
  String kepada;
  String alamat;
  String judulSkripsi;
  DateTime createdAt;
  DateTime updatedAt;

  SuratIzinSkripsiModel({
    required this.nama,
    required this.npm,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisSurat,
    required this.kepada,
    required this.alamat,
    required this.judulSkripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from a map
  factory SuratIzinSkripsiModel.fromMap(Map<String, dynamic> map) {
    return SuratIzinSkripsiModel(
      nama: map['nama'],
      npm: map['npm'],
      tempatLahir: map['tempatLahir'],
      tanggalLahir: map['tanggalLahir'].toDate(),
      jenisSurat: map['jenisSurat'],
      kepada: map['kepada'],
      alamat: map['alamat'],
      judulSkripsi: map['judulSkripsi'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Method to convert the model to a map
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'npm': npm,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'jenisSurat': jenisSurat,
      'kepada': kepada,
      'alamat': alamat,
      'judulSkripsi': judulSkripsi,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
