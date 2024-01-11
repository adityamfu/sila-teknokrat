import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/karyawan_controller.dart';

class KaryawanAddView extends GetView<KaryawanController> {
  const KaryawanAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mahasiswa'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: controller.cno_karyawan,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "No Karyawan"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.cnama_karyawan,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: "Nama Karyawan"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: controller.cjabatan_karyawan,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: "Jabatan Karyawan"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => controller.add(
                controller.cno_karyawan.text,
                controller.cnama_karyawan.text,
                controller.cjabatan_karyawan.text,
              ),
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
