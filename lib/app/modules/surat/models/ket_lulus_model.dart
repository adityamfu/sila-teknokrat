import 'package:cloud_firestore/cloud_firestore.dart';

class SuratKeteranganLulusModel {
  String nama;
  String npm;
  String tempatLahir;
  DateTime tanggalLahir;
  String jenisSurat;
  DateTime tanggalSidang;
  String judulSkripsiPa;
  DateTime createdAt;
  DateTime updatedAt;

  SuratKeteranganLulusModel({
    required this.nama,
    required this.npm,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisSurat,
    required this.tanggalSidang,
    required this.judulSkripsiPa,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from a map
  factory SuratKeteranganLulusModel.fromMap(Map<String, dynamic> map) {
    return SuratKeteranganLulusModel(
      nama: map['nama'],
      npm: map['npm'],
      tempatLahir: map['tempatLahir'],
      tanggalLahir: map['tanggalLahir'].toDate(),
      jenisSurat: map['jenisSurat'],
      tanggalSidang: (map['tanggalSidang'] as Timestamp).toDate(),
      judulSkripsiPa: map['judulSkripsiPa'],
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
      'tanggalSidang': tanggalSidang,
      'judulSkripsiPa': judulSkripsiPa,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
