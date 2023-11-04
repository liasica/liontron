import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:liontron/liontron.dart';
import 'package:liontron/models/storage_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _serialNumber = 'Unknown';
  String _internalStoragePath = 'Unknown';
  String _storageCardPath = 'Unknown';
  String _usbStoragePath = 'Unknown';
  StorageSize _internalStorageSize = StorageSize();

  final _liontronPlugin = Liontron();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _liontronPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _serialNumber = await _liontronPlugin.getSerialNumber() ?? 'Unknown serial number';
    _internalStoragePath = await _liontronPlugin.getInternalStoragePath() ?? 'Unknown internal storage path';
    _storageCardPath = await _liontronPlugin.getStorageCardPath() ?? 'Unknown storage card path';
    _usbStoragePath = await _liontronPlugin.getUsbStoragePath() ?? 'Unknown usb storage path';
    _internalStorageSize = await _liontronPlugin.getStorageSize(_internalStoragePath) ?? StorageSize();

    print('getEthMacAddress:       ${await _liontronPlugin.getEthMacAddress()}');
    print('getSerialNumber:        $_serialNumber');
    print('getInternalStoragePath: $_internalStoragePath');
    print('getStorageCardPath:     $_storageCardPath');
    print('getUsbStoragePath:      $_usbStoragePath');
    print('getStorageSize:         ${_internalStorageSize.toJson()}');
    setState(() {
      _platformVersion = platformVersion;
      _serialNumber = _serialNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion -> [$_serialNumber]\n'),
        ),
      ),
    );
  }
}
