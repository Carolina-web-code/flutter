import 'package:flutter/material.dart';
import 'package:code_scan_listener/code_scan_listener.dart';
import 'package:kiosk/qrachi.dart';
import 'achi.dart';
import 'achitare.dart';

class DiscountPage extends StatefulWidget {
  final String paymentType;

  const DiscountPage({Key? key, required this.paymentType}) : super(key: key);

  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  String? _scannedData;

  void _navigateToResultPage() {
    if (widget.paymentType == 'card') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AchiPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QRAchiPage(qrData: _scannedData ?? ''),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CodeScanListener(
      onBarcodeScanned: (String data) {
        if (mounted) {
          setState(() {
            _scannedData = data;
          });
          _navigateToResultPage();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          toolbarHeight: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AchitarePage()),
                );
              },
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MYDISCOUNT',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontFamily: 'Roboto',
                  height: 0.02,
                  letterSpacing: -1.12,
                ),
              ),
              const SizedBox(height: 30),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Vă rugăm să deschideți aplicația\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: 'MyDiscount',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: ' și să scanați QR Codul pentru\na primi bonul fiscal în format electronic.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/di.png',
                height: 500,
                width: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToResultPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Mai departe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      height: 1.2,
                      letterSpacing: -0.64,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}