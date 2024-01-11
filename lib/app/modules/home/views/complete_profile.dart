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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController npmController = TextEditingController();
  final TextEditingController agamaController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
      namaController.text = userData.nama;
      npmController.text = userData.npm;
      agamaController.text = userData.agama;
      jenisKelaminController.text = userData.jenisKelamin;
      noTeleponController.text = userData.noTelepon;
      prodiController.text = userData.prodi;
      tempatLahirController.text = userData.tempatLahir;
      selectedDate = userData.tanggalLahir;
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
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: npmController,
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
                controller: noTeleponController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  // Add phone number validation logic as needed
                  return null;
                },
              ),
              TextFormField(
                controller: prodiController,
                decoration: InputDecoration(labelText: 'Program Studi'),
                validator: (value) {
                  // Add program study validation logic as needed
                  return null;
                },
              ),
              TextFormField(
                controller: tempatLahirController,
                decoration: InputDecoration(labelText: 'Tempat Lahir'),
                validator: (value) {
                  // Add birthplace validation logic as needed
                  return null;
                },
              ),
              Row(
                children: [
                  Text(
                    "Tanggal Lahir: ${selectedDate.toLocal()}".split(' ')[0],
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
                  saveUserData();
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
      nama: namaController.text,
      npm: npmController.text,
      agama: agamaController.text,
      jenisKelamin: jenisKelaminController.text,
      noTelepon: noTeleponController.text,
      prodi: prodiController.text,
      tempatLahir: tempatLahirController.text,
      tanggalLahir: selectedDate,
    );

    await authController.saveUserDataToFirestore(userData);

    // After saving data, navigate to HomeView
    Get.offAllNamed('/home');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
          namaController.text = userData.nama;
          npmController.text = userData.npm;
          agamaController.text = userData.agama;
          jenisKelaminController.text = userData.jenisKelamin;
          noTeleponController.text = userData.noTelepon;
          prodiController.text = userData.prodi;
          tempatLahirController.text = userData.tempatLahir;
          selectedDate = userData.tanggalLahir;
          selectedAgama = userData.agama;
          selectedJenisKelamin = userData.jenisKelamin;
        });
      }
    } catch (e) {
      print('Error loading user data from Firestore: $e');
    }
  }
}
