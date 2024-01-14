import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silateknokrat/app/routes/app_pages.dart';

import '../controllers/pkl_controller.dart';

class PklView extends GetView<PklController> {
  const PklView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PKL'),
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Praktik Kerja Lapangan (PKL)',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Use a ListView for better text organization
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      buildListText('1. Mahasiswa wajib membayar biaya PKL.'),
                      buildListText('2. Setelah membayar biaya PKL, mahasiswa dapat mengajukan PKL dengan menekan tombol Buat Pengajuan.'),
                      buildListText('3. Mahasiswa memasukkan data IPK, jumlah SKS, dan mengunggah File transkrip.'),
                      buildListText('4. Mahasiswa menunggu proses validasi.'),
                      buildListText('5. Setelah pengajuan diterima, mahasiswa dapat memilih perusahaan tempat PKL.'),
                      buildListText('6. Setelah perusahaan tempat PKL divalidasi, mahasiswa menunggu surat pengantar PKL.'),
                      buildListText('7. Setelah surat pengantar PKL diambil dan diantar ke perusahaan tempat PKL, mahasiswa wajib mengunggah Surat balasan dari perusahaan.'),
                      buildListText('8. Jika diterima, mahasiswa dapat melihat jadwal pembekalan.'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.DASHBOARD);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                   shadowColor: Colors.grey.withOpacity(0.8),
                  elevation: 5,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                  child: Text(
                    'Download Surat Izin Orang Tua',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create styled text for the list items
  Widget buildListText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}
