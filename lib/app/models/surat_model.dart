class SuratModel {
  String jenisSurat;
  String status;

  SuratModel({
    required this.jenisSurat,
    required this.status,
  });

  // Factory constructor to create an instance from a map
  factory SuratModel.fromMap(Map<String, dynamic> map) {
    return SuratModel(
      jenisSurat: map['jenisSurat'],
      status: map['status'],
    );
  }

  // Method to convert the model to a map
  Map<String, dynamic> toMap() {
    return {
      'jenisSurat': jenisSurat,
      'status': status,
    };
  }
}
