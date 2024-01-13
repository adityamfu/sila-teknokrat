// Import yang diperlukan
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/surat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/izin_penelitian_model.dart';
import '../models/izin_skripsi_model.dart';
import '../models/ket_kuliah_model.dart';
import '../models/ket_lulus_model.dart';

class SuratController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  Rx<User?> firebaseUser = Rx<User?>(null);

  List<String> untukList = [
    'OrangTua',
    'Mahasiswa',
  ];

  List<String> jenisSuratList = [
    'Surat Keterangan Kuliah',
    'Surat Keterangan Lulus',
    'Surat Izin Penelitian',
    'Surat Izin Skripsi',
  ];
  RxBool validateTanggalSidang = false.obs;
  RxString selectedWidget = RxString('');
  RxString selectedJenisSurat = RxString('Surat Keterangan Kuliah');
  RxString selectedUntuk = RxString('OrangTua');
  TextEditingController tingkatController = TextEditingController();
  TextEditingController keperluanController = TextEditingController();
  TextEditingController namaOrangTuaController = TextEditingController();
  TextEditingController pekerjaanOrangTuaController = TextEditingController();
  TextEditingController instansiOrangTuaController = TextEditingController();

  TextEditingController judulSkripsiController = TextEditingController();
  TextEditingController kepadaSkripsiController = TextEditingController();
  TextEditingController alamatSkripsiController = TextEditingController();
  Rx<DateTime?> tanggalSidang = DateTime.now().obs;
  final noTeleponController = TextEditingController();
  final prodiController = TextEditingController();
  final kepadaController = TextEditingController();
  final alamatController = TextEditingController();
  final judulPenelitianController = TextEditingController();
  final mataKuliahController = TextEditingController();
  final anggotaController = TextEditingController();
  final judulSkripsiPaController = TextEditingController();

  RxBool shouldShowAdditionalFields = false.obs;
  RxBool shouldShowAdditionalFieldsBasedOnUntuk = false.obs;

  RxList<SuratIzinSkripsiModel> suratIzinSkripsiList =
      <SuratIzinSkripsiModel>[].obs;
  RxList<SuratIzinPenelitianModel> suratIzinPenelitianList =
      <SuratIzinPenelitianModel>[].obs;
  RxList<SuratKeteranganKuliahModel> suratKeteranganKuliahList =
      <SuratKeteranganKuliahModel>[].obs;
  RxList<SuratKeteranganLulusModel> suratKeteranganLulusList =
      <SuratKeteranganLulusModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSuratHistory();
    ever(selectedJenisSurat, (_) => updateShouldShowAdditionalFields());
    ever(selectedUntuk, (_) => updateShouldShowAdditionalFieldsBasedOnUntuk());
  }

  void updateSelectedJenisSurat(String value) {
    selectedJenisSurat.value = value;
  }

  void updateSelectedWidget(String value) {
    selectedWidget.value = value;
  }

  void updateShouldShowAdditionalFields() {
    shouldShowAdditionalFields.value =
        selectedJenisSurat.value == 'Surat Keterangan Kuliah';
  }

  void updateShouldShowAdditionalFieldsBasedOnUntuk() {
    shouldShowAdditionalFieldsBasedOnUntuk.value =
        selectedUntuk.value == 'OrangTua';
  }

  var isLoading = true.obs;

  Future<void> fetchSuratHistory() async {
    try {
      isLoading.value = true;

      String currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? "";

      var querySnapshotSkripsi = await FirebaseFirestore.instance
          .collection('surat_izin_skripsi')
          .doc(currentUserEmail)
          .collection('surats')
          .get();
      suratIzinSkripsiList.value = querySnapshotSkripsi.docs
          .map((doc) => SuratIzinSkripsiModel.fromMap(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();

      var querySnapshotPenelitian = await FirebaseFirestore.instance
          .collection('surat_izin_penelitian')
          .doc(currentUserEmail)
          .collection('surats')
          .get();
      suratIzinPenelitianList.value = querySnapshotPenelitian.docs
          .map((doc) => SuratIzinPenelitianModel.fromMap(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();

      var querySnapshotKetKuliah = await FirebaseFirestore.instance
          .collection('surat_keterangan_kuliah')
          .doc(currentUserEmail)
          .collection('surats')
          .get();
      suratKeteranganKuliahList.value = querySnapshotKetKuliah.docs
          .map((doc) => SuratKeteranganKuliahModel.fromMap(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();

      var querySnapshotKetLulus = await FirebaseFirestore.instance
          .collection('surat_keterangan_lulus')
          .doc(currentUserEmail)
          .collection('surats')
          .get();
      suratKeteranganLulusList.value = querySnapshotKetLulus.docs
          .map((doc) => SuratKeteranganLulusModel.fromMap(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();

      isLoading.value = false;
      // Print data di console
      suratIzinSkripsiList.forEach((surat) {
        print('Judul Skripsi: ${surat.judulSkripsi}');
      });
    } catch (error) {
      print('Error fetching Surat history: $error');
    }
  }

  Future<void> saveSuratIzinPenelitianToFirestore() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        String nama = authController.userData.value!.nama;
        String npm = authController.userData.value!.npm;
        String tempatLahir = authController.userData.value!.tempatLahir;
        DateTime tanggalLahir = authController.userData.value!.tanggalLahir;
        String jenisSurat = selectedJenisSurat.value;
        DateTime currentDate = DateTime.now();

        SuratIzinPenelitianModel suratIzinPenelitian = SuratIzinPenelitianModel(
          nama: nama,
          npm: npm,
          tempatLahir: tempatLahir,
          tanggalLahir: tanggalLahir,
          jenisSurat: jenisSurat,
          kepada: kepadaController.text,
          alamat: alamatController.text,
          judulPenelitian: judulPenelitianController.text,
          mataKuliah: mataKuliahController.text,
          anggota: anggotaController.text,
          createdAt: currentDate,
          updatedAt: currentDate,
        );

        String currentUserEmail =
            FirebaseAuth.instance.currentUser?.email ?? "";

        String documentId = "$currentDate";

        final newDocumentReference = FirebaseFirestore.instance
            .collection('surat_izin_penelitian')
            .doc(currentUserEmail)
            .collection('surats')
            .doc(documentId);

        await newDocumentReference.set(
          suratIzinPenelitian.toMap(),
        );

        formKey.currentState?.reset();
        await fetchSuratHistory();
        Get.snackbar(
            'Berhasil', 'Surat Izin Penelitian berhasil disimpan ke Firestore');
      }
    } catch (error) {
      print('Error saving Surat Izin Penelitian to Firestore: $error');
      Get.snackbar(
          'Error', 'Gagal menyimpan Surat Izin Penelitian ke Firestore');
    }
  }

  Future<void> saveSuratIzinSkripsiToFirestore() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        String nama = authController.userData.value!.nama;
        String npm = authController.userData.value!.npm;
        String tempatLahir = authController.userData.value!.tempatLahir;
        DateTime tanggalLahir = authController.userData.value!.tanggalLahir;
        String jenisSurat = selectedJenisSurat.value;
        DateTime currentDate = DateTime.now();

        SuratIzinSkripsiModel suratIzinSkripsi = SuratIzinSkripsiModel(
          nama: nama,
          npm: npm,
          tempatLahir: tempatLahir,
          tanggalLahir: tanggalLahir,
          jenisSurat: jenisSurat,
          kepada: kepadaController.text,
          alamat: alamatController.text,
          judulSkripsi: judulSkripsiController.text,
          createdAt: currentDate,
          updatedAt: currentDate,
        );

        String currentUserEmail =
            FirebaseAuth.instance.currentUser?.email ?? "";

        String documentId = "$currentDate";

        final newDocumentReference = FirebaseFirestore.instance
            .collection('surat_izin_skripsi')
            .doc(currentUserEmail)
            .collection('surats')
            .doc(documentId);

        await newDocumentReference.set(
          suratIzinSkripsi.toMap(),
        );

        formKey.currentState?.reset();
        await fetchSuratHistory();
        Get.snackbar(
            'Berhasil', 'Surat Izin Skripsi berhasil disimpan ke Firestore');
      }
    } catch (error) {
      print('Error saving Surat Izin Skripsi to Firestore: $error');
      Get.snackbar('Error', 'Gagal menyimpan Surat Izin Skripsi ke Firestore');
    }
  }

  Future<void> saveSuratKeteranganKuliahToFirestore() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        String nama = authController.userData.value!.nama;
        String npm = authController.userData.value!.npm;
        String tempatLahir = authController.userData.value!.tempatLahir;
        DateTime tanggalLahir = authController.userData.value!.tanggalLahir;
        String jenisSurat = selectedJenisSurat.value;
        DateTime currentDate = DateTime.now();

        SuratKeteranganKuliahModel suratKeteranganKuliah =
            SuratKeteranganKuliahModel(
          nama: nama,
          npm: npm,
          tempatLahir: tempatLahir,
          tanggalLahir: tanggalLahir,
          jenisSurat: jenisSurat,
          tingkat: tingkatController.text,
          untuk: selectedUntuk.value,
          namaOrangTua: namaOrangTuaController.text,
          pekerjaanOrangTua: pekerjaanOrangTuaController.text,
          instansiOrangTua: instansiOrangTuaController.text,
          keperluan: keperluanController.text,
          createdAt: currentDate,
          updatedAt: currentDate,
        );

        String currentUserEmail =
            FirebaseAuth.instance.currentUser?.email ?? "";

        String documentId = "$currentDate";

        final newDocumentReference = FirebaseFirestore.instance
            .collection('surat_keterangan_kuliah')
            .doc(currentUserEmail)
            .collection('surats')
            .doc(documentId);

        await newDocumentReference.set(
          suratKeteranganKuliah.toMap(),
        );

        formKey.currentState?.reset();
        await fetchSuratHistory();
        Get.snackbar('Berhasil',
            'Surat Keterangan Kuliah berhasil disimpan ke Firestore');
      }
    } catch (error) {
      print('Error saving Surat Keterangan Kuliah to Firestore: $error');
      Get.snackbar(
          'Error', 'Gagal menyimpan Surat Keterangan Kuliah ke Firestore');
    }
  }

  Future<void> saveSuratKeteranganLulusToFirestore() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        String nama = authController.userData.value!.nama;
        String npm = authController.userData.value!.npm;
        String tempatLahir = authController.userData.value!.tempatLahir;
        DateTime tanggalLahir = authController.userData.value!.tanggalLahir;
        String jenisSurat = selectedJenisSurat.value;
        DateTime currentDate = DateTime.now();
        DateTime tanggalSidang = DateTime.now();

        SuratKeteranganLulusModel suratKeteranganLulus =
            SuratKeteranganLulusModel(
          nama: nama,
          npm: npm,
          tempatLahir: tempatLahir,
          tanggalLahir: tanggalLahir,
          jenisSurat: jenisSurat,
          tanggalSidang: tanggalSidang,
          judulSkripsiPa: judulSkripsiPaController.text,
          createdAt: currentDate,
          updatedAt: currentDate,
        );

        String currentUserEmail =
            FirebaseAuth.instance.currentUser?.email ?? "";

        String documentId = "$currentDate";

        final newDocumentReference = FirebaseFirestore.instance
            .collection('surat_keterangan_lulus')
            .doc(currentUserEmail)
            .collection('surats')
            .doc(documentId);

        await newDocumentReference.set(
          suratKeteranganLulus.toMap(),
        );

        formKey.currentState?.reset();
        validateTanggalSidang.value = false;
        await fetchSuratHistory();
        Get.snackbar('Berhasil',
            'Surat Keterangan Lulus berhasil disimpan ke Firestore');
      }
    } catch (error) {
      print('Error saving Surat Keterangan Lulus to Firestore: $error');
      Get.snackbar(
          'Error', 'Gagal menyimpan Surat Keterangan Lulus ke Firestore');
    }
  }
}
