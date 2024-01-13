import 'package:cloud_firestore/cloud_firestore.dart';

class SuratIzinPenelitianModel {
  String nama;
  String npm;
  String tempatLahir;
  DateTime tanggalLahir;
  String jenisSurat;
  final String kepada;
  final String alamat;
  final String judulPenelitian;
  final String mataKuliah;
  final String anggota;
  DateTime createdAt;
  DateTime updatedAt;

  SuratIzinPenelitianModel({
    required this.nama,
    required this.npm,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisSurat,
    required this.kepada,
    required this.alamat,
    required this.judulPenelitian,
    required this.mataKuliah,
    required this.anggota,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from a map
  factory SuratIzinPenelitianModel.fromMap(Map<String, dynamic> map) {
    return SuratIzinPenelitianModel(
      nama: map['nama'],
      npm: map['npm'],
      tempatLahir: map['tempatLahir'],
      tanggalLahir: map['tanggalLahir'].toDate(),
      jenisSurat: map['jenisSurat'],
      kepada: map['kepada'],
      alamat: map['alamat'],
      judulPenelitian: map['judulPenelitian'],
      mataKuliah: map['mataKuliah'],
      anggota: map['anggota'],
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
      'judulPenelitian': judulPenelitian,
      'mataKuliah': mataKuliah,
      'anggota': anggota,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
