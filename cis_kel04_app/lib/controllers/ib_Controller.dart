import 'dart:convert';

import 'package:cis_kel04_app/views/mahasiswa/pages/izinBermalam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/ib_model.dart';

class IBController extends GetxController {
  Rx<List<IzinBermalamModel>> data_ib = Rx<List<IzinBermalamModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  DateTime? berangkat;
  DateTime? kembali;

  @override
  void onInit() {
    getAllDataIB();
    super.onInit();
  }

  Future getAllDataIB() async {
    try {
      isLoading.value = true;
      var response =
          await http.get(Uri.parse('${url}mahasiswa/dataIBMhs'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;

        for (var item in json.decode(response.body)['data_ib']) {
          data_ib.value.add(IzinBermalamModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createDataIB(
      {required String keterangan,
      required String tujuan,
      required DateTime berangkat,
      required DateTime kembali}) async {
    try {
      data_ib.value.clear();
      isLoading.value = true;
      var data = {
        'rencana_berangkat': berangkat.toIso8601String(),
        'rencana_kembali': kembali.toIso8601String(),
        'keterangan': keterangan,
        'tujuan': tujuan,
      };

      var response = await http.post(Uri.parse('${url}mahasiswa/ib/store'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: data);
      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.off(IzinBermalam());
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to create IB: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> updateStatus(int? id, String status) async {
    try {
      var response = await http.put(
        Uri.parse('${url}ib/$id/status-update'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: {
          'status': status,
        },
      );

      if (response.statusCode == 200) {
        // Status updated successfully
        print(json.decode(response.body));
      } else {
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
