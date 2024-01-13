import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/user_model.dart';

class UserDataFormPage extends StatefulWidget {
  @override
  _UserDataFormPageState createState() => _UserDataFormPageState();
}

class _UserDataFormPageState extends State<UserDataFormPage> {
  final AuthController authController = Get.find<AuthController>();

  List<String> agamaList = ["Islam", "Kristen", "Hindu", "Buddha", "Lainnya"];
  String selectedAgama = "Islam";

  List<String> jenisKelaminList = ["Laki-laki", "Perempuan", "Lainnya"];
  String selectedJenisKelamin = "Laki-laki";

  @override
  void initState() {
    super.initState();

    // Load existing user data if available
    if (authController.userData.value != null) {
      UserData userData = authController.userData.value!;
      authController.namaController.text = userData.nama;
      authController.npmController.text = userData.npm;
      authController.agamaController.text = userData.agama;
      authController.jenisKelaminController.text = userData.jenisKelamin;
      authController.noTeleponController.text = userData.noTelepon;
      authController.prodiController.text = userData.prodi;
      authController.tempatLahirController.text = userData.tempatLahir;
      authController.selectedDate = userData.tanggalLahir;
      selectedAgama = userData.agama;
      selectedJenisKelamin = userData.jenisKelamin;
    } else {
      // Check if user data is available in the complete_profiles collection
      loadUserDataFromFirestore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengisian Data Pengguna"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: authController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: authController.namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: authController.npmController,
                decoration: InputDecoration(labelText: 'NPM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NPM wajib diisi';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedAgama,
                items: agamaList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedAgama = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Agama'),
              ),
              DropdownButtonFormField<String>(
                value: selectedJenisKelamin,
                items: jenisKelaminList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedJenisKelamin = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              TextFormField(
                controller: authController.noTeleponController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  // Add phone number validation logic as needed
                  return null;
                },
              ),
              TextFormField(
                controller: authController.prodiController,
                decoration: InputDecoration(labelText: 'Program Studi'),
                validator: (value) {
                  // Add program study validation logic as needed
                  return null;
                },
              ),
              TextFormField(
                controller: authController.tempatLahirController,
                decoration: InputDecoration(labelText: 'Tempat Lahir'),
                validator: (value) {
                  // Add birthplace validation logic as needed
                  return null;
                },
              ),
              Row(
                children: [
                  Text(
                    "Tanggal Lahir: ${authController.selectedDate.toLocal()}"
                        .split(' ')[0],
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Pilih Tanggal'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (authController.formKey.currentState?.validate() ??
                      false) {
                    // The form is valid, proceed with saving user data
                    saveUserData();
                  } else {
                    // The form is not valid, display an error or take appropriate action
                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveUserData() async {
    final userData = UserData(
      nama: authController.namaController.text,
      npm: authController.npmController.text,
      agama: authController.agamaController.text,
      jenisKelamin: authController.jenisKelaminController.text,
      noTelepon: authController.noTeleponController.text,
      prodi: authController.prodiController.text,
      tempatLahir: authController.tempatLahirController.text,
      tanggalLahir: authController.selectedDate,
    );

    await authController.saveUserDataToFirestore(userData);

    // After saving data, navigate to HomeView
    Get.offAllNamed('/home');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: authController.selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != authController.selectedDate) {
      setState(() {
        authController.selectedDate = picked;
      });
    }
  }

  Future<void> loadUserDataFromFirestore() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('complete_profiles')
          .where('email', isEqualTo: authController.firebaseUser.value?.email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        UserData userData = UserData.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
        setState(() {
          authController.namaController.text = userData.nama;
          authController.npmController.text = userData.npm;
          authController.agamaController.text = userData.agama;
          authController.jenisKelaminController.text = userData.jenisKelamin;
          authController.noTeleponController.text = userData.noTelepon;
          authController.prodiController.text = userData.prodi;
          authController.tempatLahirController.text = userData.tempatLahir;
          authController.selectedDate = userData.tanggalLahir;
          selectedAgama = userData.agama;
          selectedJenisKelamin = userData.jenisKelamin;
        });
      }
    } catch (e) {
      print('Error loading user data from Firestore: $e');
    }
  }
}
