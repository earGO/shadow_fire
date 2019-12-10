import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_ble/flutter_ble.dart';
import 'package:shadowrun/types/check_in_arguments.dart';
import 'package:shadowrun/widgets/check_in_dialogue.dart';

class CheckInScreen extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;

  static String routeName = '/checkInScreen';

  const CheckInScreen({this.start = true});

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  FlutterBle _flutterBlue = FlutterBle.instance;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<DeviceIdentifier, ScanResult> scanResults = new Map();
  bool isScanning = false;
  bool wasError = false;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  /// Device
  BluetoothDevice device;
  bool get isConnected => (device != null);
  StreamSubscription deviceConnection;
  StreamSubscription deviceStateSubscription;
  List<BluetoothService> services = new List();
  Map<Guid, StreamSubscription> valueChangedSubscriptions = {};
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  @override
  void initState() {
    super.initState();
    // Immediately get the state of FlutterBle
    _flutterBlue.state.then((s) {
      setState(() {
        state = s;
      });
    });
    // Subscribe to state changes
    _stateSubscription = _flutterBlue.onStateChanged().listen((s) {
      setState(() {
        state = s;
      });
    });
    _startScan();
  }

  _startScan() {
    try {
      _scanSubscription = _flutterBlue
          .scan(
        timeout: const Duration(seconds: 7),
        /*withServices: [
          new Guid('0000180F-0000-1000-8000-00805F9B34FB')
        ]*/
      )
          .listen((scanResult) {
        setState(() {
          scanResults[scanResult.device.id] = scanResult;
        });
      }, onDone: _stopScan);

      setState(() {
        isScanning = true;
      });
    } catch (e) {
      setState(() {
        isScanning = false;
        wasError = true;
      });
    }
  }

  _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    setState(() {
      isScanning = false;
    });
  }

  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    _scanSubscription?.cancel();
    _scanSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CheckInArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: wasError
          ? Center(
              child: Text(
                'Проверьте, включён ли Bluetooth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : isScanning
              ? Center(
                  child: Container(
                  height: MediaQuery.of(context).size.height * .25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Определяю маяки вокруг',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    ],
                  ),
                ))
              : CheckInDialogue(
                  neededSsid: args.ssid,
                  devices: scanResults,
                  locationName: args.locationName,
                  locationId: args.locationId,
                ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
