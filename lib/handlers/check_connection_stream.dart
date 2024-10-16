import 'dart:async';

import 'package:app/utils/routes.dart';
import 'package:app/utils/theme.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';

class CheckConnectionStream extends GetxController {
  bool isModalEnable = false;
  final loadingCheckConnectivity = false.obs;

  // ignore: unused_field
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();

      loadingCheckConnectivity.value = false;
    } on PlatformException {
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;

    if (result == ConnectivityResult.none) {
      if (isModalEnable != true) {
        isModalEnable = true;
        showDialogIfNotConnect();
      }
    } else {
      if (isModalEnable) {
        Get.closeAllSnackbars();
        Get.offAllNamed(GetRoutes.splash);
      }
      isModalEnable = false;
    }
  }

  showDialogIfNotConnect() {

    var context = navigator!.context;
    var customDialog = Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 530,
          ),
          decoration: BoxDecoration(
            color: AppTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x33000000),
                offset: Offset(
                  0,
                  1,
                ),
              )
            ],
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.of(context).primaryBackground,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: Icon(
                            Icons
                                .signal_cellular_connected_no_internet_4_bar_rounded,
                            color: AppTheme.of(context).secondaryText,
                            size: 44,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          "Check your Internet Connectivity".tr,
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                              .headlineMedium
                              .overriden(
                            fontFamily: 'PT Sans',
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Text(
                          "Your device is not currently connected to the Internet".tr,
                          style:
                          AppTheme.of(context).labelMedium.overriden(
                            fontFamily: 'Roboto Mono',
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => loadingCheckConnectivity.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                loadingCheckConnectivity.value = true;
                                EasyDebounce.debounce(
                                    'check connectivity',
                                    const Duration(milliseconds: 1000), () async {
                                  await initConnectivity();
                                });
                              },
                              child: Text(
                                'Try again'.tr,
                                style: const TextStyle(color: Colors.black),
                              ),
                            )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Get.dialog(customDialog, barrierDismissible: false);
    Get.showSnackbar(const GetSnackBar(message: "Your device is not currently connected to the Internet",));

    // Get.defaultDialog(
    //     barrierDismissible: false,
    //     title: "Check your Internet Connectivity".tr,
    //     onWillPop: () async {
    //       return false;
    //     },
    //     middleText: "Your device is not currently connected to the Internet".tr,
    //     titleStyle: TextStyle(
    //       color: Get.isDarkMode ? Colors.white : Colors.black,
    //     ),
    //     middleTextStyle: TextStyle(
    //       color: Get.isDarkMode ? Colors.white : Colors.black,
    //     ),
    // );
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}