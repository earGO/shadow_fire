import 'dart:async';
import 'package:flutter_ble/flutter_ble.dart';

class BluetoothScan {
  FlutterBle _flutterBlue = FlutterBle.instance;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<DeviceIdentifier, ScanResult> _scanResults = new Map();


  List<ScanResult> _extractResults(Map<DeviceIdentifier, ScanResult> results){
    return results.values.map((value)=> value).toList();
  }

   List<ScanResult> getList()  {
    try {
      _flutterBlue
          .scan(
        timeout: const Duration(seconds: 1),
        /*withServices: [
          new Guid('0000180F-0000-1000-8000-00805F9B34FB')
        ]*/
      )
          .listen((scanResult) {

         _scanResults[scanResult.device.id] = scanResult;

      }, onDone: stopScan);
      return _extractResults(_scanResults);
    } catch (e) {
      return [];
    }
  }

  void stopScan() {
    _scanSubscription.cancel();
    _scanSubscription = null;
  }


}
