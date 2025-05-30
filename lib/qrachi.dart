import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'achitare.dart';
import 'meniu.dart';

class QRAchiPage extends StatefulWidget {
  final String qrData;

  const QRAchiPage({Key? key, required this.qrData}) : super(key: key);

  @override
  _QRAchiPageState createState() => _QRAchiPageState();
}

class _QRAchiPageState extends State<QRAchiPage> {
  @override
  void initState() {
    super.initState();
    // Set up a timer to navigate after 15 seconds
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MeniuPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Image.asset(
                'assets/bifa.png',
                height: 60,
                width: 60,
              ),
              const SizedBox(height: 40),
              const Text(
                'Bon înregistrat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bonul a fost înregistrat cu succes!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: QrImageView(
                  data: widget.qrData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Verifică versiunea electronică a bonului!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AchitarePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}