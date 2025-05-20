import 'package:core_retail/data/bill/models/line/restaurant_line_model.dart';
import 'package:core_retail/data/price_list/models/assortment/topping_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiosk/price_list/price_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'generated/l10n.dart';
import 'order.dart';
import 'scan.dart';
import 'product_overlay.dart';
import 'package:kiosk/provider/cart_provider.dart';
import 'package:kiosk/provider/menu_translations.dart';

class MeniuPage extends StatefulWidget {
  const MeniuPage({super.key});

  @override
  State<MeniuPage> createState() => _MeniuPageState();
}
class _MeniuPageState extends State<MeniuPage> {

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
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 40,
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