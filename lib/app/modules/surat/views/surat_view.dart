import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/surat_model.dart';
import '../controllers/surat_controller.dart';
import 'surat_add_view.dart';

class SuratView extends StatelessWidget {
  final SuratController suratController = Get.put(SuratController());
  final AuthController authController = Get.find<AuthController>();
  int indexCounter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surat History"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi Surat Keterangan (Su-Ket)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "1. Saudara wajib memperhatikan ketentuan Pengajuan Surat Keterangan.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "2. Pengajuan Surat Keterangan hanya dapat dilakukan oleh mahasiswa yang tidak dalam masa cuti.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "3. Pastikan Saudara sudah membayar biaya perkuliahan semester yang aktif saat ini.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "4. Surat yang disetujui dan telah selesai dibuat WAJIB diambil di BAAKU, jika surat tidak diambil, maka permohonan selanjutnya tidak akan dilayani (Ditolak oleh sistem secara Otomatis).",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "5. Untuk Permohonan Surat Keterangan Kuliah hanya dapat dilakukan sekali di setiap semester untuk keperluan yang sama.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "6. Untuk Permohonan Surat Keterangan Lulus hanya dapat dilakukan jika sudah lulus.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "7. Untuk melihat/download Surat Keterangan Kuliah dapat dilakukan melalui kolom Action > Download Suket",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.to(SuratAddView());
              },
              child: Text("Ajukan Surat Keterangan"),
            ),
            Text(
              "Surat History",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (suratController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                suratController.suratIzinSkripsiList
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                suratController.suratIzinPenelitianList
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                suratController.suratKeteranganKuliahList
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                suratController.suratKeteranganLulusList
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));

                return (suratController.suratIzinSkripsiList.isNotEmpty ||
                        suratController.suratIzinPenelitianList.isNotEmpty ||
                        suratController.suratKeteranganKuliahList.isNotEmpty ||
                        suratController.suratKeteranganLulusList.isNotEmpty)
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Create At')),
                            DataColumn(label: Text('Jenis Surat')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: [
                            ...suratController.suratIzinSkripsiList.map(
                              (surat) {
                                int index = indexCounter++;
                                return DataRow(
                                  cells: [
                                    DataCell(Text('$index')),
                                    DataCell(
                                      Text(
                                        _formatDateTime(surat.createdAt),
                                      ),
                                    ),
                                    DataCell(Text(surat.jenisSurat)),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          // Implement action for Surat Izin Skripsi
                                        },
                                        child: Text("Detail"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            ...suratController.suratIzinPenelitianList.map(
                              (surat) {
                                int index = indexCounter++;
                                return DataRow(
                                  cells: [
                                    DataCell(Text('$index')),
                                    DataCell(
                                      Text(
                                        _formatDateTime(surat.createdAt),
                                      ),
                                    ),
                                    DataCell(Text(surat.jenisSurat)),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          // Implement action for Surat Izin Skripsi
                                        },
                                        child: Text("Detail"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            ...suratController.suratKeteranganKuliahList.map(
                              (surat) {
                                int index = indexCounter++;
                                return DataRow(
                                  cells: [
                                    DataCell(Text('$index')),
                                    DataCell(
                                      Text(
                                        _formatDateTime(surat.createdAt),
                                      ),
                                    ),
                                    DataCell(Text(surat.jenisSurat)),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          // Implement action for Surat Izin Skripsi
                                        },
                                        child: Text("Detail"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            ...suratController.suratKeteranganLulusList.map(
                              (surat) {
                                int index = indexCounter++;
                                return DataRow(
                                  cells: [
                                    DataCell(Text('$index')),
                                    DataCell(
                                      Text(
                                        _formatDateTime(surat.createdAt),
                                      ),
                                    ),
                                    DataCell(Text(surat.jenisSurat)),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          // Implement action for Surat Izin Skripsi
                                        },
                                        child: Text("Detail"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text('Belum ada Pengajuan'),
                      );
              }
            }),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    var formatter = DateFormat('dd MMMM yyyy HH:mm:ss');
    return formatter.format(dateTime);
  }
}
