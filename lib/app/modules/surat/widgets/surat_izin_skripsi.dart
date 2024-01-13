// surat_izin_skripsi.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/surat_controller.dart';

class SuratIzinSkripsiFields extends StatelessWidget {
  final SuratController suratController = Get.find<SuratController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Tanggal Lahir: ${authController.userData.value!.tanggalLahir.toLocal().toString().split(' ')[0]}"),
          TextFormField(
            decoration: InputDecoration(labelText: 'Kepada'),
            onSaved: (value) => suratController.kepadaController.text = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Kepada tidak boleh kosong';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Alamat'),
            onSaved: (value) => suratController.alamatController.text = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Alamat tidak boleh kosong';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Judul Skripsi'),
            onSaved: (value) =>
                suratController.judulSkripsiController.text = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Judul Skripsi tidak boleh kosong';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (suratController.formKey.currentState?.validate() ?? false) {
                suratController.formKey.currentState?.save();
                await suratController.saveSuratIzinSkripsiToFirestore();
              }
            },
            child: Text('Simpan'),
          ),
        ],
      );
    });
  }
}
