import 'package:flutter/material.dart';
import 'package:kiosk/qrachi.dart';
import 'achi.dart';
import 'discount.dart';
import 'meniu.dart';
import 'operatiunifisc.dart';
import 'scan.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'generated/l10n.dart';

class AchitarePage extends StatefulWidget {
  const AchitarePage({Key? key}) : super(key: key);

  @override
  _AchitarePageState createState() => _AchitarePageState();
}

class _AchitarePageState extends State<AchitarePage> {
  bool isCashPressed = false;
  bool isCardPressed = false;
  bool isDiscountPressed = false;

  Future<void> _navigateWithDelay(VoidCallback navigateTo, String buttonType) async {
    setState(() {
      if (buttonType == 'cash') {
        isCashPressed = true;
      } else if (buttonType == 'card') {
        isCardPressed = true;
      } else if (buttonType == 'discount') {
        isDiscountPressed = true;
      }
    });

    await Future.delayed(const Duration(milliseconds: 300));

    navigateTo();

    setState(() {
      if (buttonType == 'cash') {
        isCashPressed = false;
      } else if (buttonType == 'card') {
        isCardPressed = false;
      } else if (buttonType == 'discount') {
        isDiscountPressed = false;
      }
    });
  }

  Widget _buildPaymentOption({
    required BuildContext context,
    required double width,
    required double height,
    required Widget? image,
    required String text,
    required bool isPressed,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isPressed ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            boxShadow: isPressed
                ? [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ]
                : null,
          ),
          child: Stack(
            children: [
              if (image == null)
                Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: isPressed ? Colors.black : Colors.white,
                      fontSize: 20,
                      fontFamily: 'Arial',
                      height: 1.2,
                      letterSpacing: -0.4,
                      shadows: isPressed
                          ? [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.yellow.withOpacity(0.8),
                        )
                      ]
                          : null,
                    ),
                    child: Text(text),
                  ),
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 60),
                      child: image,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 60),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
                          fontSize: 20,
                          fontFamily: 'Arial',
                          height: 1.5,
                          letterSpacing: -0.4,
                          shadows: isPressed
                              ? [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.yellow.withOpacity(0.8),
                            )
                          ]
                              : null,
                        ),
                        child: Text(text),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/pizza_center.png',
          width: 70,
          height: 70,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPaymentOption(
                  context: context,
                  width: 200,
                  height: 134,
                  image: Container(
                    height: 50,
                    child: Image.asset('assets/card.png'),
                  ),
                  text: S.of(context).card,
                  isPressed: isCardPressed,
                  onTap: () {
                    _navigateWithDelay(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DiscountPage(paymentType: 'card'),
                        ),
                      );
                    }, 'card');
                  },
                ),
                const SizedBox(width: 5),
                _buildPaymentOption(
                  context: context,
                  width: 200,
                  height: 134,
                  image: Container(
                    height: 50,
                    child: Image.asset('assets/numerar.png'),
                  ),
                  text: S.of(context).num,
                  isPressed: isCashPressed,
                  onTap: () {
                    _navigateWithDelay(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DiscountPage(paymentType: 'cash'),
                        ),
                      );
                    }, 'cash');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: _buildPaymentOption(
                  context: context,
                  width: 200,
                  height: 130,
                  image: null,
                  text: 'MyDiscount',
                  isPressed: isDiscountPressed,
                  onTap: () {
                    _navigateWithDelay(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OperatiuniFiscalePage()),
                      );
                    }, 'discount');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}