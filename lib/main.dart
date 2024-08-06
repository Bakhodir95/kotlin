import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(FlashlightApp());
}

class FlashlightApp extends StatelessWidget {
  const FlashlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FlashlightHomePage(),
    );
  }
}

class FlashlightHomePage extends StatefulWidget {
  const FlashlightHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlashlightHomePageState createState() => _FlashlightHomePageState();
}

class _FlashlightHomePageState extends State<FlashlightHomePage> {
  static const platform = MethodChannel('com.example.flashlight/flashlight');
  bool _isOn = false;

  Future<void> _toggleFlashlight() async {
    try {
      await platform.invokeMethod('toggleFlashlight', {'isOn': !_isOn});
      setState(() {
        _isOn = !_isOn;
      });
    } on PlatformException catch (e) {
      print("Failed to toggle flashlight: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashlight App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _toggleFlashlight,
          child: Text(_isOn ? 'Turn Off' : 'Turn On'),
        ),
      ),
    );
  }
}
