import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'achitare.dart';
import 'generated/l10n.dart';
import 'meniu.dart';
import 'package:kiosk/provider/cart_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isBackButtonPressed = false;
  bool isPaymentButtonPressed = false;

  Future<void> _navigateWithDelay(Function navigationFunction, bool isBackButton) async {
    setState(() {
      if (isBackButton) {
        isBackButtonPressed = true;
      } else {
        isPaymentButtonPressed = true;
      }
    });

    await Future.delayed(const Duration(seconds: 1));

    navigationFunction();

    setState(() {
      if (isBackButton) {
        isBackButtonPressed = false;
      } else {
        isPaymentButtonPressed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isPackage = cartProvider.isPackage;
    final totalPrice = cartProvider.totalPrice;

    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/pizza_center.png',
              width: 70,
              height: 70,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false).changeLocale("ro");
                  },
                  child: Text(
                    'RO',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Arial',
                      height: 2,
                      letterSpacing: -0.96,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false).changeLocale("ru");
                  },
                  child: Text(
                    'RU',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Arial',
                      height: 2,
                      letterSpacing: -0.96,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                S.of(context).myOrder,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Arial',
                  height: 0.02,
                ),
              ),
              const SizedBox(height:35),
              Text(
                isPackage ? S.of(context).pachet : S.of(context).loc,
                style: const TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 32,
                  fontFamily: 'Arial',
                  height: 0.04,
                  letterSpacing: -0.64,
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/chee.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.broken_image, color: Colors.white);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.assortment.name??'',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(item.quantity * (item.assortment.price??0)) +(item.toppings?.map((e)=>(e.quantity??0) * e.toppingData.price).reduce((a,b)=> a+b)??0)} MDL',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, color: Colors.white),
                                    onPressed: () {
                                      // Dacă cantitatea este 1, eliminăm produsul din cart
                                      if (item.quantity <= 1) {
                                        cart.removeFromCart(item.assortment.id ?? '');
                                      } else {
                                        cart.updateQuantity(
                                          item.assortment.id??'',
                                          (item.quantity - 1).toInt(),
                                        );
                                      }
                                    },
                                  ),
                                  Text(
                                    item.quantity.toInt().toString(), // Afișăm ca întreg
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, color: Colors.white),
                                    onPressed: () {
                                      cart.updateQuantity(
                                        item.assortment.id??'',
                                        (item.quantity + 1).toInt(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cart.removeFromCart(item.assortment.id!);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Total price section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).total,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${totalPrice.toStringAsFixed(2)} MDL',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Butoanele Inapoi și Achitare
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Butonul Inapoi
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: isBackButtonPressed ? Colors.white : Colors.transparent,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: isBackButtonPressed ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          _navigateWithDelay(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MeniuPage()),
                            );
                          }, true);
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            S.of(context).i,
                            key: ValueKey<bool>(isBackButtonPressed),
                            style: TextStyle(
                              color: isBackButtonPressed ? Colors.black : Colors.white,
                              fontSize: 24,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Butonul Achitare
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: isPaymentButtonPressed ? Colors.white : Colors.transparent,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: isPaymentButtonPressed ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          _navigateWithDelay(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AchitarePage()),
                            );
                          }, false);
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            S.of(context).n,
                            key: ValueKey<bool>(isPaymentButtonPressed),
                            style: TextStyle(
                              color: isPaymentButtonPressed ? Colors.black : Colors.white,
                              fontSize: 24,
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
            ],
          ),
        ),
      ),
    );
  }
}