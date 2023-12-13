import 'dart:convert';

import 'package:cis_kel04_app/models/ik_model.dart';
import 'package:cis_kel04_app/views/baak/pages/BaakIzinKeluar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

class BaakIKController extends GetxController {
  Rx<List<IzinKeluarModel>> all_ik = Rx<List<IzinKeluarModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllDataIK();
    super.onInit();
  }

  Future getAllDataIK() async {
    try {
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}baak/ik'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;

        for (var item in json.decode(response.body)['data_ik']) {
          all_ik.value.add(IzinKeluarModel.fromJson(item));
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

  Future<void> updateStatus(int? id, String status) async {
    try {
      var response = await http.put(
        Uri.parse('${url}baak/ik/$id/status-update'),
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

  void removeIzinData(int index) {
    List<IzinKeluarModel> updatedList = List.from(all_ik.value);
    updatedList.removeAt(index);
    all_ik.value = updatedList;
  }
}
