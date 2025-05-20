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
  const PizzaPage({super.key});

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> {
  @override
  void initState() {
    context.read<FiscalConnectionBloc>().add(InitFiscal());
    context.read<McrConnectionBloc>().add(InitMcr());
    context.read<PriceListBloc>().add(InitPriceList());
    super.initState();
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
                'assets/pizza_background.png', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),

            // Center image
            Center(
              child: Image.asset(
                'assets/pizza_center.png',
                // Replace with your center image path
                width: 300,
                height: 300,
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
                  icon: Icon(Icons.settings, color: Colors.black, size: 30),
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
                    child: Text(
                      'RO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
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
                    child: Text(
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

            // Footer with two white rectangles
            // Footer with two white rectangles
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // First rectangle - "La loc"
                    // First rectangle - "La loc"
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          orderTypeProvider.setPackage(false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeniuPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color:
                                !orderTypeProvider.isPackage
                                    ? Colors.yellow
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            S.of(context).loc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
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

                    // Second rectangle - "La pachet"
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          orderTypeProvider.setPackage(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeniuPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color:
                                orderTypeProvider.isPackage
                                    ? Colors.yellow
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            S.of(context).pachet,
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
