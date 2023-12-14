import 'dart:convert';

import 'package:cis_kel04_app/constants/constants.dart';
import 'package:cis_kel04_app/models/mahasiswa.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/dashboard.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MhsAuthenticationController extends GetxController {
  void onInit() {
    getMahasiswaData();
    super.onInit();
  }

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
        Uri.parse('${url}mahasiswa/register'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;

        Get.offAll(() => const MhsLogin());
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
        Uri.parse('${url}mahasiswa/login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        token.value = json.decode(response.body)["token"];
        box.write('token', token.value);

        MahasiswaModel mahasiswa =
            MahasiswaModel.fromJson(json.decode(response.body)["mahasiswa"]);

        // Store Mahasiswa data in GetStorage
        box.write('mahasiswa', mahasiswa.toJson());
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

  void logout() {
    box.remove('token');
    Get.offAll(() => const MhsLogin());
  }

  Future<MahasiswaModel?> getMahasiswaData() async {
    try {
      String storedToken = box.read('token') ?? '';
      if (storedToken.isEmpty) {
        // Token is not available, return null or handle as appropriate
        return null;
      }

      var response = await http.get(
        Uri.parse('${url}get_mahasiswa_data'),
        headers: {'Authorization': 'Bearer $storedToken'},
      );

      if (response.statusCode == 200) {
        var mahasiswaData =
            MahasiswaModel.fromJson(json.decode(response.body)['mahasiswa']);
        return mahasiswaData;
      } else {
        // Handle error or return null
        print(json.decode(response.body));
        return null;
      }
    } catch (e) {
      // Handle error or return null
      print(e.toString());
      return null;
    }
  }

  Future<MahasiswaModel?> getDashboardData() async {
    try {
      String storedToken = box.read('token') ?? '';
      if (storedToken.isEmpty) {
        // Token is not available, return null or handle as appropriate
        return null;
      }

      var response = await http.get(
        Uri.parse('${url}dashboard'),
        headers: {'Authorization': 'Bearer $storedToken'},
      );

      if (response.statusCode == 200) {
        var mahasiswaData = MahasiswaModel.fromJson(
            json.decode(response.body)['data_mahasiswa']);
        return mahasiswaData;
      } else {
        // Handle error or return null
        print(json.decode(response.body));
        return null;
      }
    } catch (e) {
      // Handle error or return null
      print(e.toString());
      return null;
    }
  }
}
