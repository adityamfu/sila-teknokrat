import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterWidget extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController npmController = TextEditingController();
  final TextEditingController agamaController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController noTelponController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: npmController,
              decoration: InputDecoration(labelText: 'NPM'),
            ),
            TextField(
              controller: agamaController,
              decoration: InputDecoration(labelText: 'Agama'),
            ),
            TextField(
              controller: jenisKelaminController,
              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            TextField(
              controller: noTelponController,
              decoration: InputDecoration(labelText: 'No Telpon'),
            ),
            TextField(
              controller: prodiController,
              decoration: InputDecoration(labelText: 'Prodi'),
            ),
            TextField(
              controller: tanggalLahirController,
              decoration: InputDecoration(labelText: 'Tanggal Lahir'),
            ),
            TextField(
              controller: tempatLahirController,
              decoration: InputDecoration(labelText: 'Tempat Lahir'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_validateFields()) {
                  _authController.register(
                    username: usernameController.text,
                    password: passwordController.text,
                    email: emailController.text,
                    npm: npmController.text,
                    agama: agamaController.text,
                    jenisKelamin: jenisKelaminController.text,
                    noTelpon: noTelponController.text,
                    prodi: prodiController.text,
                    tanggalLahir:
                        DateTime.tryParse(tanggalLahirController.text) ??
                            DateTime.now(),
                    tempatLahir: tempatLahirController.text,
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk validasi field
  bool _validateFields() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        npmController.text.isEmpty ||
        agamaController.text.isEmpty ||
        jenisKelaminController.text.isEmpty ||
        noTelponController.text.isEmpty ||
        prodiController.text.isEmpty ||
        tanggalLahirController.text.isEmpty ||
        tempatLahirController.text.isEmpty) {
      // Tampilkan pesan atau notifikasi validasi jika diperlukan
      Get.snackbar('Error', 'Semua field harus diisi');
      return false;
    }
    return true;
  }
}
