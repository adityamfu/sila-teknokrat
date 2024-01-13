import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/surat_model.dart';
import '../../home/views/complete_profile.dart';
import '../controllers/surat_controller.dart';
import '../widgets/surat_izin_penelitian.dart';
import '../widgets/surat_izin_skripsi.dart';
import '../widgets/surat_ket_kuliah.dart';
import '../widgets/surat_ket_lulus.dart';

class SuratAddView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final SuratController suratController = Get.put(SuratController());

  Widget buildUserDataSection() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (authController.userData.value != null) ...[
            Text("Nama: ${authController.userData.value!.nama}"),
            Text("NPM: ${authController.userData.value!.npm}"),
            Text("Program Studi: ${authController.userData.value!.prodi}"),
            Text("Tempat Lahir: ${authController.userData.value!.tempatLahir}"),
            Text(
                "Tanggal Lahir: ${authController.userData.value!.tanggalLahir.toLocal().toString().split(' ')[0]}"),
          ] else
            Column(
              children: [
                const Text(
                    "Belum melengkapi profil. Silakan lengkapi profil Anda."),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => UserDataFormPage());
                  },
                  child: Text("Lengkapi Profil"),
                ),
              ],
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Surat"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUserDataSection(),
            if (authController.userData.value != null)
              Form(
                key: suratController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: suratController.selectedJenisSurat.value,
                      items: suratController.jenisSuratList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          suratController.updateSelectedJenisSurat(value);
                          suratController.updateSelectedWidget(value);
                          suratController.updateShouldShowAdditionalFields();
                        }
                      },
                      decoration: InputDecoration(labelText: 'Jenis Surat'),
                    ),
                    Obx(() {
                      if (suratController.selectedWidget.value ==
                          'Surat Keterangan Kuliah') {
                        return SuratKeteranganKuliahFields();
                      } else if (suratController.selectedWidget.value ==
                          'Surat Keterangan Lulus') {
                        return SuratKeteranganLulusFields();
                      } else if (suratController.selectedWidget.value ==
                          'Surat Izin Penelitian') {
                        return SuratIzinPenelitianFields();
                      } else if (suratController.selectedWidget.value ==
                          'Surat Izin Skripsi') {
                        return SuratIzinSkripsiFields();
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
