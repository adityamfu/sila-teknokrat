import 'package:cloud_firestore/cloud_firestore.dart';

class SuratModel {
  String jenisSurat;
  String status;
  DateTime createdAt;

  SuratModel({
    required this.jenisSurat,
    required this.status,
    required this.createdAt,
  });

  // Factory constructor to create an instance from a map
  factory SuratModel.fromMap(Map<String, dynamic> map) {
    return SuratModel(
      jenisSurat: map['jenisSurat'],
      status: map['status'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Method to convert the model to a map
  Map<String, dynamic> toMap() {
    return {
      'jenisSurat': jenisSurat,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
