import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../home/views/complete_profile.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (authController.userData.value != null) ...[
                  Text("Nama: ${authController.userData.value!.nama}"),
                  Text("NPM: ${authController.userData.value!.npm}"),
                  Text("Agama: ${authController.userData.value!.agama}"),
                  Text(
                      "Jenis Kelamin: ${authController.userData.value!.jenisKelamin}"),
                  Text(
                      "Nomor Telepon: ${authController.userData.value!.noTelepon}"),
                  Text(
                      "Program Studi: ${authController.userData.value!.prodi}"),
                  Text(
                      "Tempat Lahir: ${authController.userData.value!.tempatLahir}"),
                  Text(
                      "Tanggal Lahir: ${authController.userData.value!.tanggalLahir.toLocal().toString().split(' ')[0]}"),
                ] else
                  Column(
                    children: [
                      Text(
                          "Belum melengkapi profil. Silakan lengkapi profil Anda."),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to UserDataFormPage for editing
                          Get.to(() => UserDataFormPage());
                        },
                        child: Text("Lengkapi Profil"),
                      ),
                    ],
                  ),
              ],
            )),
      ),
    );
  }
}
