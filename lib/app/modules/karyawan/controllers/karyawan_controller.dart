import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KaryawanController extends GetxController {
  //TODO: Implement karyawanController
  late TextEditingController cnama_karyawan;
  late TextEditingController cno_karyawan;
  late TextEditingController cjabatan_karyawan;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference karyawan = firestore.collection('karyawan_21312103');

    return karyawan.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference karyawan = firestore.collection('karyawan_21312103');
    return karyawan.snapshots();
  }

  void add(
      String no_karyawan, String nama_karyawan, String jabatan_karyawan) async {
    CollectionReference products = firestore.collection("karyawan_21312103");

    try {
      await products.add({
        "no_karyawan": no_karyawan,
        "nama_karyawan": nama_karyawan,
        "jabatan_karyawan": jabatan_karyawan,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data karyawan",
          onConfirm: () {
            cno_karyawan.clear();
            cnama_karyawan.clear();
            cjabatan_karyawan.clear();
            Get.back();
            Get.back();
            Get.back();
            textConfirm:
            "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Karyawan.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef =
        firestore.collection("karyawan_21312103").doc(id);

    return docRef.get();
  }

  void Update(String no_karyawan, String nama_karyawan, String jabatan_karyawan,
      String id) async {
    DocumentReference productById =
        firestore.collection("karyawan_21312103").doc(id);

    try {
      await productById.update({
        "no_karyawan": no_karyawan,
        "nama_karyawan": nama_karyawan,
        "jabatan_karyawan": jabatan_karyawan,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data Karyawan.",
        onConfirm: () {
          cno_karyawan.clear();
          cnama_karyawan.clear();
          cjabatan_karyawan.clear();
          Get.back();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan karyawan.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef =
        firestore.collection("karyawan_21312103").doc(id);

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
    cno_karyawan = TextEditingController();
    cnama_karyawan = TextEditingController();
    cjabatan_karyawan = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cno_karyawan.dispose();
    cnama_karyawan.dispose();
    cjabatan_karyawan.dispose();
    super.onClose();
  }
}
