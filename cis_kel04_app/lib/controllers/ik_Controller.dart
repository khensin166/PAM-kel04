import 'package:cis_kel04_app/constants/constants.dart';
import 'package:cis_kel04_app/models/ik_model.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/izinKeluar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class IKController extends GetxController {
  Rx<List<IzinKeluarModel>> data_ik = Rx<List<IzinKeluarModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  DateTime? berangkat;
  DateTime? kembali;

  @override
  void onInit() {
    getAllDataIK();
    super.onInit();
  }

  Future getAllDataIK() async {
    try {
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}ik'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in json.decode(response.body)['data_ik']) {
          data_ik.value.add(IzinKeluarModel.fromJson(item));
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

  Future createDataIK(
      {required String keterangan,
      required DateTime berangkat,
      required DateTime kembali}) async {
    try {
      data_ik.value.clear();
      isLoading.value = true;
      var data = {
        'berangkat': berangkat.toIso8601String(),
        'kembali': kembali.toIso8601String(),
        'keterangan': keterangan,
      };

      var response = await http.post(Uri.parse('${url}ik/store'),
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
        Get.to(IzinKeluar());
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to create IK: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
