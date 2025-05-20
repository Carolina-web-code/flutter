import 'package:flutter/material.dart';
import 'achi.dart';
import 'meniu.dart';
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

    await Future.delayed(const Duration(seconds: 1));

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
            // First row with two rectangles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Numerar option
                _buildPaymentOption(
                  context: context,
                  width: 200,
                  height: 150,
                  image: Container(
                    height: 50,
                    child: Image.asset('assets/numerar.png'),
                  ),
                  text: S.of(context).num,
                  isPressed: isCashPressed,
                  onTap: () {
                    // No navigation for cash option (as per your original code)
                    // Just showing the pressed state for demonstration
                    _navigateWithDelay(() {}, 'cash');
                  },
                ),
                const SizedBox(width: 5),
                // Card bancar option
                _buildPaymentOption(
                  context: context,
                  width: 200,
                  height: 150,
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
                        MaterialPageRoute(builder: (context) => const AchiPage()),
                      );
                    }, 'card');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // MyDiscount option
            _buildPaymentOption(
              context: context,
              width: 200,
              height: 150,
              image: null,
              text: 'MyDiscount',
              isPressed: isDiscountPressed,
              onTap: () {
                _navigateWithDelay(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MeniuPage()),
                  );
                }, 'discount');
              },
            ),
          ],
        ),
      ),
    );
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
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isPressed ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
          ),
          child: Stack(
            children: [
              image == null
                  ? Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isPressed ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontFamily: 'Arial',
                    height: 1.2,
                    letterSpacing: -0.4,
                  ),
                ),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 60),
                    child: ColorFiltered(
                      colorFilter: isPressed
                          ? const ColorFilter.mode(
                          Colors.black, BlendMode.srcIn)
                          : const ColorFilter.mode(
                          Colors.white, BlendMode.srcIn),
                      child: image,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 50),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isPressed ? Colors.black : Colors.white,
                        fontSize: 20,
                        fontFamily: 'Arial',
                        height: 1.5,
                        letterSpacing: -0.4,
                      ),
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
}