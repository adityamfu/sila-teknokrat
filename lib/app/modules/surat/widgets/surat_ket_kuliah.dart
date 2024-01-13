import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/surat_controller.dart';

class SuratKeteranganKuliahFields extends StatelessWidget {
  final SuratController suratController = Get.find<SuratController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          TextFormField(
            controller: suratController.tingkatController,
            decoration: InputDecoration(labelText: 'Tingkat/Semester'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tingkat/Semester wajib diisi';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: suratController.selectedUntuk.value,
            items: suratController.untukList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              suratController.selectedUntuk.value = value!;
              suratController.updateShouldShowAdditionalFieldsBasedOnUntuk();
            },
            decoration: InputDecoration(labelText: 'Untuk'),
          ),
          if (suratController.shouldShowAdditionalFieldsBasedOnUntuk.value) ...[
            if (suratController.selectedUntuk.value == 'OrangTua') ...[
              TextFormField(
                controller: suratController.namaOrangTuaController,
                decoration: InputDecoration(labelText: 'Nama Orang Tua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Orang Tua wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: suratController.pekerjaanOrangTuaController,
                decoration: InputDecoration(labelText: 'Pekerjaan Orang Tua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pekerjaan Orang Tua wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: suratController.instansiOrangTuaController,
                decoration: InputDecoration(labelText: 'Instansi Orang Tua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Instansi Orang Tua wajib diisi';
                  }
                  return null;
                },
              ),
            ],
            if (suratController.selectedUntuk.value == 'Mahasiswa') ...[
              // Add additional fields specific for 'Mahasiswa' if needed
            ],
          ],
          TextFormField(
            controller: suratController.keperluanController,
            decoration: InputDecoration(labelText: 'Keperluan'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Keperluan wajib diisi';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (suratController.formKey.currentState?.validate() ?? false) {
                suratController.formKey.currentState?.save();
                await suratController.saveSuratKeteranganKuliahToFirestore();
              }
            },
            child: Text('Simpan'),
          ),
        ],
      );
    });
  }
}
