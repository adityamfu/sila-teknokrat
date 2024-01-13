// surat_keterangan_lulus.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/surat_controller.dart';

class SuratKeteranganLulusFields extends StatelessWidget {
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
            decoration: InputDecoration(labelText: 'Tanggal Sidang'),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: suratController.tanggalSidang.value ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                suratController.tanggalSidang.value = pickedDate;
              }
            },
            controller: TextEditingController(
              text: suratController.tanggalSidang.value != null
                  ? DateFormat('dd-MM-yyyy')
                      .format(suratController.tanggalSidang.value!)
                  : '',
            ),
            validator: (value) {
              if (suratController.tanggalSidang.value == null) {
                return 'Pilih tanggal sidang';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Judul Skripsi'),
            onSaved: (value) =>
                suratController.judulSkripsiPaController.text = value!,
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
                await suratController.saveSuratKeteranganLulusToFirestore();
              }
            },
            child: Text('Simpan'),
          ),
        ],
      );
    });
  }
}
