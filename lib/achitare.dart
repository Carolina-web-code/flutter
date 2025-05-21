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

class _AchitarePageState extends State<AchitarePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  bool isCashPressed = false;
  bool isCardPressed = false;
  bool isDiscountPressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  Widget _buildAnimatedPaymentOption({
    required BuildContext context,
    required double width,
    required double height,
    required Widget? image,
    required String text,
    required bool isPressed,
    required VoidCallback onTap,
    required int index,
  }) {
    final double delay = index * 0.2;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animationValue = _controller.value;
        final animatedValue = (animationValue - delay).clamp(0.0, 1.0);

        return Opacity(
          opacity: _opacityAnimation.value * animatedValue,
          child: Transform.translate(
            offset: _slideAnimation.value * (1 - animatedValue),
            child: Transform.scale(
              scale: _scaleAnimation.value * animatedValue,
              child: child,
            ),
          ),
        );
      },
      child: GestureDetector(
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
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: ColorFiltered(
                            key: ValueKey<bool>(isPressed),
                            colorFilter: isPressed
                                ? const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn)
                                : const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                            child: image,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 50),
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
        title: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            'assets/pizza_center.png',
            width: 70,
            height: 70,
          ),
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
                _buildAnimatedPaymentOption(
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
                    _navigateWithDelay(() {}, 'cash');
                  },
                  index: 0,
                ),
                const SizedBox(width: 5),
                // Card bancar option
                _buildAnimatedPaymentOption(
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
                  index: 1,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // MyDiscount option
            _buildAnimatedPaymentOption(
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
              index: 2,
            ),
          ],
        ),
      ),
    );
  }
}