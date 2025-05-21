import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiosk/price_list/price_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Added animated_text_kit package
import 'generated/l10n.dart';
import 'order.dart';
import 'package:kiosk/provider/cart_provider.dart';

class MeniuPage extends StatefulWidget {
  const MeniuPage({super.key});

  @override
  State<MeniuPage> createState() => _MeniuPageState();
}

class _MeniuPageState extends State<MeniuPage> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup fade animation for price
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Provider.of<LanguageProvider>(context).curentLocale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PriceListWidget(),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: Colors.black,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrderPage()),
                      );
                    },
                    child: Stack(
                      children: [
                        // Shopping cart icon with pulse animation
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 1.0, end: 1.2),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: child,
                            );
                          },
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Consumer<CartProvider>(
                            builder: (context, cart, child) {
                              return cart.totalItems > 0
                                  ? Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  cart.totalItems.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // "Total" text with typewriter animation
                  const SizedBox(width: 20),
                  Text(
                    S.of(context).total,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Arial',
                      height: 1.2,
                      letterSpacing: -0.96,
                    ),
                  ),
                  const Spacer(),
                  Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return Text(
                        '${cart.totalPrice.toStringAsFixed(2)} MDL',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Arial',
                          height: 1.2,
                          letterSpacing: -0.96,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}