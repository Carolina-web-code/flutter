import 'package:core_retail/resources/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiosk/price_list/price_list_widget.dart';
import 'package:kiosk/scan.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'generated/l10n.dart';
import 'order.dart';
import 'package:kiosk/provider/cart_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async'; // Add this import for Timer

class MeniuPage extends StatefulWidget {
  const MeniuPage({super.key});

  @override
  State<MeniuPage> createState() => _MeniuPageState();
}

class _MeniuPageState extends State<MeniuPage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Timer? _inactivityTimer;
  final Duration _inactivityDuration = const Duration(minutes: 1);
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetInactivityTimer();
    }
  }

  void _resetInactivityTimer() {
    // _inactivityTimer?.cancel();
    // _inactivityTimer = Timer(_inactivityDuration, _showInactivityDialog);
  }

  void _showInactivityDialog() {
    if (_isDialogShowing) return;

    _inactivityTimer?.cancel();
    _inactivityTimer = null;
    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          title: S.of(context).inactivityTitle,
          subtitle: S.of(context).inactivityMessage,
          titleButton: S.of(context).yes,
          secondButtonTitle: S.of(context).no,
          onTap: () {
            _isDialogShowing = false;
            Provider.of<CartProvider>(context, listen: false).clearCart();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PizzaPage()),
            );
          },
          onTapSecond: () {
            _isDialogShowing = false;
            Navigator.of(context).pop();
            _resetInactivityTimer();
          },
          showCancelButton: false,
        );
      },
    ).then((_) {
      _isDialogShowing = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _resetInactivityTimer(),
      child: MaterialApp(
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Colors.black,
                child: Row(
                  children: [
                    // Custom shopping basket image with counter
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OrderPage()),
                        );
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/ico.png',
                            width: 30, // Adjust size as needed
                            height: 30, // Adjust size as needed
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
                    const SizedBox(width: 10),

                    // "Total" text and price moved together
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        return Row(
                          children: [
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
                            const SizedBox(width: 10),
                            Text(
                              '${cart.totalPrice.toStringAsFixed(2)} MDL',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Arial',
                                height: 1.2,
                                letterSpacing: -0.96,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const Spacer(),

                    // "Vezi comanda" button that changes color and behavior based on cart content
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        return GestureDetector(
                          onTap: cart.totalItems > 0
                              ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OrderPage()),
                            );
                          }
                              : null,
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: cart.totalItems > 0 ? Colors.yellow : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                'Vezi comanda',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Arial',
                                  height: 0.05,
                                  letterSpacing: -0.48,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}