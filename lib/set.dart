import 'package:flutter/material.dart';
import 'package:kiosk/servicesettings.dart';

import 'operatiunifisc.dart';

class SettPage extends StatelessWidget {
  const SettPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Setări',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            height: 0.07,
            letterSpacing: 0.50,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OperatiuniFiscalePage()),
              );
            },
            child: _buildRow(Icons.print, 'Operațiuni fiscale'),
          ),
          _buildDivider(),
          _buildRow(Icons.layers, 'Departamente'),
          _buildDivider(),
          _buildRow(Icons.refresh, 'Actualizare'),
          _buildDivider(),
          _buildRow(Icons.dashboard_customize, 'Dashboard'),
          _buildDivider(),
          _buildRow(Icons.language, 'Limba'),
          _buildDivider(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Services()),
              );
            },
            child: _buildRow(Icons.settings, 'Setări generale'),
          ),
          _buildDivider(),
          _buildRow(Icons.info_outline, 'Despre aplicație'),
          _buildDivider(),
          _buildRow(Icons.brightness_6, 'Aspect fundal'),
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: Icon(icon, size: 20, color: Colors.grey),
          ),
          const SizedBox(width: 16.0),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              height: 0.08,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 52.0, right: 32.0),
      height: 1.0,
      color: Colors.grey[300],
    );
  }
}