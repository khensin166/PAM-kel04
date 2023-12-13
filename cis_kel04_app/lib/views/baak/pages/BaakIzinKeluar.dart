import 'package:cis_kel04_app/controllers/BaakIKController.dart';
import 'package:cis_kel04_app/controllers/ik_Controller.dart';
import 'package:cis_kel04_app/views/widgets/baakIK_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaakIzinKeluar extends StatefulWidget {
  const BaakIzinKeluar({super.key});

  @override
  State<BaakIzinKeluar> createState() => _BaakIzinKeluarState();
}

class _BaakIzinKeluarState extends State<BaakIzinKeluar> {
  BaakIKController _baakIKController = Get.put(BaakIKController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Ik'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(() {
                return _baakIKController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _baakIKController.all_ik.value.length,
                        itemBuilder: (context, index) {
                          var izinKeluarModel =
                              _baakIKController.all_ik.value[index];
                          return izinKeluarModel.status == 'approved'
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Obx(() {
                                  return _baakIKController.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : IzinData(
                                          izinKeluarModel: izinKeluarModel,
                                          onApprovePressed: () async {
                                            await _baakIKController
                                                .updateStatus(
                                                    izinKeluarModel.id,
                                                    'approved');
                                            _baakIKController
                                                .removeIzinData(index);
                                          },
                                          onRejectPressed: () async {
                                            await _baakIKController
                                                .updateStatus(
                                                    izinKeluarModel.id,
                                                    'rejected');
                                            _baakIKController
                                                .removeIzinData(index);
                                          },
                                        );
                                });
                        });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
