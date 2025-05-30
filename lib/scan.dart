import 'package:core_retail/presentation/price_list/bloc/price_list_bloc.dart';
import 'package:core_retail/presentation/services/bloc/fiscal_connection_bloc/fiscal_connection_bloc.dart';
import 'package:core_retail/presentation/services/bloc/mcr_connection_bloc/mcr_connection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiosk/servicesettings.dart';
import 'package:proto_definitions/generated/price_list.pb.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'package:kiosk/provider/order_type_provider.dart';
import 'generated/l10n.dart';
import 'meniu.dart';

class PizzaPage extends StatefulWidget {
  const PizzaPage({
    super.key,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.easeInOut,
  });

  final Duration duration;
  final Curve curve;

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animation;
  bool _isButtonPressed = false;
  int? _currentPressedButton; // 1 pentru "La loc", 2 pentru "La pachet"

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.forward();

    // Initialize blocs
    context.read<FiscalConnectionBloc>().add(InitFiscal());
    context.read<McrConnectionBloc>().add(InitMcr());
    context.read<PriceListBloc>().add(InitPriceList());
  }

  @override
  void didUpdateWidget(PizzaPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.curve != widget.curve) {
      _animation.curve = widget.curve;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleButtonTap(int buttonId) {
    setState(() {
      _isButtonPressed = true;
      _currentPressedButton = buttonId;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isButtonPressed = false;
      });

      final orderTypeProvider = Provider.of<OrderTypeProvider>(context, listen: false);
      if (buttonId == 1) {
        orderTypeProvider.setPackage(false);
      } else {
        orderTypeProvider.setPackage(true);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MeniuPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderTypeProvider = Provider.of<OrderTypeProvider>(context);

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
        body: Stack(
          children: [
            // Full screen background image
            Positioned.fill(
              child: Image.asset(
                'assets/pizza_background.png',
                fit: BoxFit.cover,
              ),
            ),

            // Center image with animation
            Center(
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/pizza_center.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),

            // AppBar with back button
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Services()),
                    );
                  },
                ),
              ),
            ),

            // Language selector
            Positioned(
              top: 35,
              right: 20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<LanguageProvider>(
                        context,
                        listen: false,
                      ).changeLocale("ro");
                      Provider.of<LanguageProvider>(
                        context,
                        listen: false,
                      ).saveLanguageToSp();
                    },
                    child: const Text(
                      'RO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      Provider.of<LanguageProvider>(
                        context,
                        listen: false,
                      ).changeLocale("ru");
                      Provider.of<LanguageProvider>(
                        context,
                        listen: false,
                      ).saveLanguageToSp();
                    },
                    child: const Text(
                      'RU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer with two animated buttons
            Positioned(
              bottom: 50, // Butoanele sunt ridicate mai sus
              left: 0,
              right: 0,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // First button - "La loc"
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _handleButtonTap(1),
                          child: Transform.scale(
                            scale: _isButtonPressed && _currentPressedButton == 1 ? 0.95 : 1.0,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: !orderTypeProvider.isPackage
                                    ? Colors.yellow
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: _isButtonPressed && _currentPressedButton == 1
                                    ? [
                                  BoxShadow(
                                    color: Colors.black,
                                        //.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 5),
                                  )
                                ]
                                    : null,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                S.of(context).loc,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Arial',
                                  height: 0.04,
                                  letterSpacing: -0.64,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Second button - "La pachet"
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _handleButtonTap(2),
                          child: Transform.scale(
                            scale: _isButtonPressed && _currentPressedButton == 2 ? 0.95 : 1.0,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: orderTypeProvider.isPackage
                                    ? Colors.yellow
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: _isButtonPressed && _currentPressedButton == 2
                                    ? [
                                  BoxShadow(
                                    color: Colors.black,
                                        //.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 5),
                                  )
                                ]
                                    : null,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                S.of(context).pachet,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Arial',
                                  height: 0.04,
                                  letterSpacing: -0.64,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}