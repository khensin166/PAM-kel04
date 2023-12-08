import 'dart:convert';

import 'package:cis_kel04_app/constants/constants.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MhsAuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future register({
    required String ktp,
    required String nim,
    required String nama,
    required String handphone,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'ktp': ktp,
        'nim': nim,
        'nama': nama,
        'handphone': handphone,
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;

        token.value = json.decode(response.body)["token"];
        box.write('token', token.value);
        Get.offAll(() => const MhsDashboard());
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }


  Future login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        token.value = json.decode(response.body)["token"];
        box.write('token', token.value);
        Get.offAll(() => const MhsDashboard());
        // print(json.decode(response.body));
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
