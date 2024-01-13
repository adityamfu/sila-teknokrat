import 'package:cloud_firestore/cloud_firestore.dart';

class SuratKeteranganKuliahModel {
  String nama;
  String npm;
  String tempatLahir;
  DateTime tanggalLahir;
  String jenisSurat;
  final String tingkat;
  final String untuk;
  final String keperluan;
  final String namaOrangTua;
  final String pekerjaanOrangTua;
  final String instansiOrangTua;
  DateTime createdAt;
  DateTime updatedAt;

  SuratKeteranganKuliahModel({
    required this.nama,
    required this.npm,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisSurat,
    required this.tingkat,
    required this.untuk,
    required this.keperluan,
    required this.namaOrangTua,
    required this.pekerjaanOrangTua,
    required this.instansiOrangTua,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from a map
  factory SuratKeteranganKuliahModel.fromMap(Map<String, dynamic> map) {
    return SuratKeteranganKuliahModel(
      nama: map['nama'],
      npm: map['npm'],
      tempatLahir: map['tempatLahir'],
      tanggalLahir: map['tanggalLahir'].toDate(),
      jenisSurat: map['jenisSurat'],
      tingkat: map['tingkat'],
      untuk: map['untuk'],
      keperluan: map['keperluan'],
      namaOrangTua: map['namaOrangTua'],
      pekerjaanOrangTua: map['pekerjaanOrangTua'],
      instansiOrangTua: map['instansiOrangTua'],
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
      'tingkat': tingkat,
      'untuk': untuk,
      'keperluan': keperluan,
      'namaOrangTua': namaOrangTua,
      'pekerjaanOrangTua': pekerjaanOrangTua,
      'instansiOrangTua': instansiOrangTua,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
