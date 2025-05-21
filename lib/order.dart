import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'achitare.dart';
import 'generated/l10n.dart';
import 'meniu.dart';
import 'package:kiosk/provider/cart_provider.dart';
import 'package:flutter/animation.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin {
  bool isBackButtonPressed = false;
  bool isPaymentButtonPressed = false;
  late AnimationController _controller;
  late Animation<double> _titleAnimation;
  late Animation<double> _deliveryTypeAnimation;
  late Animation<double> _totalLabelAnimation;
  late Animation<double> _totalValueAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Configure different animations for different text elements
    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _deliveryTypeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.elasticOut),
      ),
    );

    _totalLabelAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeInOut),
      ),
    );

    _totalValueAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.bounceOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  Widget _buildAnimatedText(String text, Animation<double> animation, TextStyle style,
      {TextAlign align = TextAlign.left, bool scale = true, bool fade = true, bool slide = false}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: fade ? animation.value : 1.0,
          child: Transform(
            transform: Matrix4.identity()
              ..scale(scale ? animation.value : 1.0)
              ..translate(slide ? (1 - animation.value) * 20 : 0.0),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: style,
        textAlign: align,
      ),
    );
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
                  child: _buildAnimatedText(
                    'RO',
                    _controller,
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Arial',
                      height: 2,
                      letterSpacing: -0.96,
                    ),
                    scale: false,
                    fade: true,
                    slide: true,
                  ),
                ),
                SizedBox(width: 20.w),
                InkWell(
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false).changeLocale("ru");
                  },
                  child: _buildAnimatedText(
                    'RU',
                    _controller,
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Arial',
                      height: 2,
                      letterSpacing: -0.96,
                    ),
                    scale: false,
                    fade: true,
                    slide: true,
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
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              _buildAnimatedText(
                S.of(context).myOrder,
                _titleAnimation,
                const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Arial',
                  height: 0.02,
                ),
                scale: true,
                fade: true,
              ),
              const SizedBox(height: 40),
              _buildAnimatedText(
                isPackage ? S.of(context).pachet : S.of(context).loc,
                _deliveryTypeAnimation,
                const TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 32,
                  fontFamily: 'Arial',
                  height: 0.04,
                  letterSpacing: -0.64,
                ),
                scale: true,
                fade: true,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300 + (index * 100)),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.only(bottom: 20),
                          transform: Matrix4.translationValues(
                              0,
                              cart.items.length == index + 1 ? 0 : (1 - _controller.value) * 50,
                              0
                          ),
                          child: Opacity(
                            opacity: _controller.value,
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
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.assortment.name??'',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
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
                                        cart.updateQuantity(
                                          item.assortment.id??'',
                                          (item.quantity - 1).toInt(),
                                        );
                                      },
                                    ),
                                    Text(
                                      item.quantity.toString(),
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
                    _buildAnimatedText(
                      S.of(context).total,
                      _totalLabelAnimation,
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                      scale: true,
                      fade: true,
                    ),
                    _buildAnimatedText(
                      '${totalPrice.toStringAsFixed(2)} MDL',
                      _totalValueAnimation,
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                      scale: true,
                      fade: true,
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutBack,
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutBack,
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