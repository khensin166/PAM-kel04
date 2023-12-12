import 'dart:convert';
import 'package:cis_kel04_app/views/baak/pages/dashboard.dart';
import 'package:cis_kel04_app/views/baak/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:cis_kel04_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaakAuthenticationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

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
        Uri.parse('${url}baak/login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        token.value = json.decode(response.body)["token"];
        box.write('token', token.value);
        Get.offAll(() => const BaakDashboard());
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
    Get.offAll(() => const BaakLogin());
  }
}
