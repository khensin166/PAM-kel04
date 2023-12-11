import 'package:cis_kel04_app/constants/constants.dart';
import 'package:cis_kel04_app/models/ik_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class IKController extends GetxController {
  Rx<List<IzinKeluarModel>> data_ik = Rx<List<IzinKeluarModel>>([]);
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
}
