import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DosenController extends GetxController {
  //TODO: Implement dosenController
  late TextEditingController cNidn;
  late TextEditingController cNama;
  late String selectedStatus = ''; // New variable
  final List<String> statusOptions = [
    'Active',
    'Inactive',
  ]; // Define your options

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference dosen = firestore.collection('21312103_dosen');

    return dosen.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference dosen = firestore.collection('21312103_dosen');
    return dosen.snapshots();
  }

  void add(String nidn, String nama, String status) async {
    CollectionReference products = firestore.collection("21312103_dosen");

    try {
      await products.add({
        "midn": nidn,
        "nama": nama,
        "status": selectedStatus,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data dosen",
          onConfirm: () {
            cNidn.clear();
            cNama.clear();
            Get.back();
            Get.back();
            textConfirm:
            "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan dosen.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("21312103_dosen").doc(id);

    return docRef.get();
  }

  void Update(String nidn, String nama, String id) async {
    DocumentReference productById =
        firestore.collection("21312103_dosen").doc(id);

    try {
      await productById.update({
        "nidn": nidn,
        "nama": nama,
        "status": selectedStatus,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data dosen.",
        onConfirm: () {
          cNidn.clear();
          cNama.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan dosen.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef = firestore.collection("21312103_dosen").doc(id);

    try {
      Get.defaultDialog(
        title: "Info",
        middleText: "Apakah anda yakin menghapus data ini ?",
        onConfirm: () {
          docRef.delete();
          Get.back();
          Get.defaultDialog(
            title: "Sukses",
            middleText: "Berhasil menghapus data",
          );
        },
        textConfirm: "Ya",
        textCancel: "Batal",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Tidak berhasil menghapus data",
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cNidn = TextEditingController();
    cNama = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNidn.dispose();
    cNama.dispose();
    super.onClose();
  }
}
