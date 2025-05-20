import 'package:core_retail/core_retail.dart';
import 'package:core_retail/resources/helpers/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'package:kiosk/provider/order_type_provider.dart';
import 'package:kiosk/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Storage.setTestMode(isTestMode: true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider<OrderTypeProvider>(
          create: (context) => OrderTypeProvider()..loadFromSP(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Payment Page',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: Provider.of<LanguageProvider>(context).curentLocale,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: PayPage(),
        );
      },
    );
  }
}

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  double amount = 100.0; // Suma de plată
  String paymentMethod = 'card'; // Metoda de plată implicită

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).payment),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            // Afișează suma de plată
            Text(
              '${S.of(context).payment_amount}: ${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.h),

            // Selector pentru metoda de plată
            DropdownButton<String>(
              value: paymentMethod,
              items: [
                DropdownMenuItem(
                  value: 'card',
                  child: Text(S.of(context).card_payment),
                ),
                DropdownMenuItem(
                  value: 'cash',
                  child: Text(S.of(context).cash_payment),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
            ),
            SizedBox(height: 40.h),

            // Buton pentru inițierea plății
            ElevatedButton(
              onPressed: (){},
              child: Text(S.of(context).make_payment),
            ),
            SizedBox(height: 40.h),


          ],
        ),
      ),
    );
  }



  void _handlePaymentSuccess(String transactionId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${S.of(context).payment_success}: $transactionId'),
        backgroundColor: Colors.green,
      ),
    );
    // Poți adăuga navigare sau alte acțiuni după plată reușită
  }

  void _handlePaymentError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${S.of(context).payment_error}: $error'),
        backgroundColor: Colors.red,
      ),
    );
  }
}