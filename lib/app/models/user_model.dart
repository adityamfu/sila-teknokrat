import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String nama;
  String npm;
  String agama;
  String jenisKelamin;
  String noTelepon;
  String prodi;
  String tempatLahir;
  DateTime tanggalLahir;

  UserData({
    required this.nama,
    required this.npm,
    required this.agama,
    required this.jenisKelamin,
    required this.noTelepon,
    required this.prodi,
    required this.tempatLahir,
    required this.tanggalLahir,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      nama: map['nama'] ?? '',
      npm: map['npm'] ?? '',
      agama: map['agama'] ?? '',
      jenisKelamin: map['jenisKelamin'] ?? '',
      noTelepon: map['noTelepon'] ?? '',
      prodi: map['prodi'] ?? '',
      tempatLahir: map['tempatLahir'] ?? '',
      tanggalLahir: (map['tanggalLahir'] as Timestamp).toDate(),
    );
  }
}
