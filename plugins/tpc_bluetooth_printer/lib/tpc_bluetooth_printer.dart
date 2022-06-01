
import 'dart:async';

import 'package:flutter/services.dart';

class TpcBluetoothPrinter {
  static const MethodChannel _channel = MethodChannel('tpc_bluetooth_printer');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<Map<String, dynamic>> bluetoothPrint({
    required String textToPrint,
    required String macAddress,
  }) async {
    final params = <String, dynamic>{
      'textToPrint': textToPrint,
      'macAddress': macAddress
    };
    var result = <String,dynamic>{};
    try {
      result = {
        'success':true,
        'data': await _channel.invokeMethod('bluetoothPrint', params)
      };
    } on PlatformException catch(e) {
      result = {
        'success':false,
        'data':e
      };
    }
    return result;
  }
  

  static Future<Map<String, dynamic>> checkStatus({required macAddress}) async {
    final params = <String, dynamic>{'macAddress': macAddress};
    var result = <String,dynamic>{};
    try {
      result = {
        'success':true,
        'data': await _channel.invokeMethod('checkStatus', params)
      };
    } on PlatformException catch(e) {
      result = {
        'success':false,
        'data':e
      };
    }
    return result;
  }


  static Future<Map<String, dynamic>> listPrinters() async {
    final params = <String, dynamic>{};
    var result = <String,dynamic>{};
    try {
      result = {
        'success':true,
        'data': await _channel.invokeMethod('listPrinters', params)
      };
    } on PlatformException catch(e) {
      result = {
        'success':false,
        'data':e
      };
    }
    return result;
  }
}
