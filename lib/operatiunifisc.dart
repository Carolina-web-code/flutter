import 'package:flutter/material.dart';
import 'package:kiosk/set.dart';

class OperatiuniFiscalePage extends StatelessWidget {
  const OperatiuniFiscalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Operațiuni fiscale',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            height: 0.07,
            letterSpacing: 0.50,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Text(
              'X',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettPage()),
              );
            },
          ),
        ],
        elevation: 0,
      ),
      body: Column(

        children: [
          _buildRowWithLetter('x', 'Imprimare raport X'),
          _buildDivider(),
          _buildRowWithLetter('z', 'Imprimare raport Z'),
          _buildDivider(),
          _buildRow(Icons.description_outlined, 'Rapoarte fiscale'),
          _buildDivider(),
          _buildRow(Icons.picture_as_pdf_outlined, 'Copia bonului fiscal'),
          _buildDivider(),
          _buildRow(Icons.arrow_upward, 'Introducerea banilor'),
          _buildDivider(),
          _buildRow(Icons.arrow_downward, 'Extragerea banilor'),
        ],
      ),
    );
  }

  Widget _buildRowWithLetter(String letter, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
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