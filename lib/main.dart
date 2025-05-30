import 'dart:developer';
import 'package:core_retail/core_retail.dart';
import 'package:core_retail/generated/l10n.dart';
import 'package:core_retail/presentation/pay/bloc/pay_bloc.dart';
import 'package:core_retail/presentation/price_list/bloc/price_list_bloc.dart';
import 'package:core_retail/presentation/restaurant_assortment_preference/bloc/restaurant_assortment_preference_bloc.dart';
import 'package:core_retail/presentation/services/bloc/fiscal_connection_bloc/fiscal_connection_bloc.dart';
import 'package:core_retail/presentation/services/bloc/local_server_connection_bloc/local_server_connection_bloc.dart';
import 'package:core_retail/presentation/services/bloc/mcr_connection_bloc/mcr_connection_bloc.dart';
import 'package:core_retail/resources/helpers/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/conection.dart';
import 'package:kiosk/provider/language_provider.dart';
import 'package:kiosk/provider/order_type_provider.dart';
import 'package:kiosk/provider/cart_provider.dart';
import 'package:kiosk/servicesettings.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'scan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Storage.setTestMode(isTestMode: true);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LanguageProvider>(
      create: (context) => LanguageProvider(),
    ),
    ChangeNotifierProvider<OrderTypeProvider>(
      create: (context) => OrderTypeProvider()..loadFromSP(),
    ),
    ChangeNotifierProvider<CartProvider>(
      create: (context) => CartProvider(),
    ),

  ], child: MultiBlocProvider(
providers: [
  BlocProvider(create: (_)=> LocalServerConnectionBloc()),
  BlocProvider(create: (_)=> FiscalConnectionBloc()),
  BlocProvider(create: (_)=> McrConnectionBloc()),
  BlocProvider(create: (_)=> PayBloc()),
  BlocProvider(create: (_)=> PriceListBloc()),
  BlocProvider(create: (_)=> RestaurantAssortmentPreferenceBloc())
],
      child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(600, 960),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'License Activation',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: Provider.of<LanguageProvider>(context).curentLocale,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            LibS.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: child,
        );
      },
      child: LicenseActivationScreen(),
    );
  }
}

class LicenseActivationScreen extends StatefulWidget {
  @override
  _LicenseActivationScreenState createState() => _LicenseActivationScreenState();
}

class _LicenseActivationScreenState extends State<LicenseActivationScreen> {
  List<String> licenseDigits = List.filled(8, '');
  int currentDigitIndex = 0;
  bool light = true;

  @override
  void initState() {
 isSavedLicence();
    super.initState();
  }

  void isSavedLicence() async{
    final response= await CoreRetail.instance.licenseRepository.isSavedLicenseToStorage();

    log(response.toString(), name: 'IsSavedLicense');

    if(response==true)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionWidget()),
    );
  }

  Future<void> _handleDigitPressed(String digit) async {
    if (currentDigitIndex < 8) {
      setState(() {
        licenseDigits[currentDigitIndex] = digit;
        currentDigitIndex++;
      });

      // Check if all digits are entered
      if (currentDigitIndex == 8) {
        //CoreRetail().licenseRepository.isSavedLicenseToStorage();

        final response = await CoreRetail.instance.licenseRepository.activateLicense(
            licenseCode: licenseDigits.join());

        response.fold((left) {
          // Show error message for left case
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Licența nu lucrează'),
              backgroundColor: Colors.red,
            ),
          );
          // Reset the license digits
          setState(() {
            licenseDigits = List.filled(8, '');
            currentDigitIndex = 0;
          });
        }, (right) {
          // Navigate to PizzaPage for right case
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ConnectionWidget()),
          );
        });
      }
    }
  }

  void _handleBackspacePressed() {
    if (currentDigitIndex > 0) {
      setState(() {
        currentDigitIndex--;
        licenseDigits[currentDigitIndex] = '';
      });
    }
  }

  void _handleSettingsPressed() {
    // Aici poți adăuga logica pentru butonul de settings
    print('Settings button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            // RO/RU at the very top
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 50.h, right: 20.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<LanguageProvider>(context, listen: false).changeLocale("ro");
                        Provider.of<LanguageProvider>(context, listen: false).saveLanguageToSp();
                      },
                      child: Text(
                        'RO',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Arial',
                          height: 2,
                          letterSpacing: -0.96,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    InkWell(
                      onTap: () {
                        Provider.of<LanguageProvider>(context, listen: false).changeLocale("ru");
                        Provider.of<LanguageProvider>(context, listen: false).saveLanguageToSp();
                      },
                      child: Text(
                        'RU',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Arial',
                          height: 2,
                          letterSpacing: -0.96,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h), // Space after RO/RU

            // Title
            Text(
              S.of(context).sign_in,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 60.h),

            // Subtitle
            Text(
              '${S.of(context).opt} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                height: 0.02,
              ),
            ),

            SizedBox(height: 10.h),

            // License input boxes (90×94)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (index) {
                return Container(
                  width: 90.w,
                  height: 94.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.w),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  child: Center(
                    child: Text(
                      licenseDigits[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 35.h),

            // Switch button
            Switch(
              value: light,
              activeColor: Colors.red,
              onChanged: (bool value) {
                setState(() {
                  light = value;
                });
              },
            ),

            SizedBox(height: 5.h),

            Text(
              '${S.of(context).regim} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),

            Spacer(),

            // Numeric keypad (larger buttons with Figma styling)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDigitButton('7'),
                    SizedBox(width: 20.w),
                    _buildDigitButton('8'),
                    SizedBox(width: 20.w),
                    _buildDigitButton('9'),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDigitButton('4'),
                    SizedBox(width: 20.w),
                    _buildDigitButton('5'),
                    SizedBox(width: 20.w),
                    _buildDigitButton('6'),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDigitButton('1'),
                    SizedBox(width: 20.w),
                    _buildDigitButton('2'),
                    SizedBox(width: 20.w),
                    _buildDigitButton('3'),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSettingsButton(), // Butonul nou de settings
                    SizedBox(width: 20.w),
                    _buildDigitButton('0'),
                    SizedBox(width: 20.w),
                    _buildBackspaceButton(),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDigitButton(String digit) {
    return GestureDetector(
      onTap: () => _handleDigitPressed(digit),
      child: Container(
        width: 317.33.w,
        height: 121.91.h,
        padding: EdgeInsets.only(
          top: 12.h,
          left: 12.w,
          right: 12.33.w,
          bottom: 11.91.h,
        ),
        decoration: ShapeDecoration(
          color: Color(0xFFF1F1F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Center(
          child: Text(
            digit,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: 'Work Sans',
              height: 0.02,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return GestureDetector(
      onTap: _handleBackspacePressed,
      child: Container(
        width: 317.33.w,
        height: 121.91.h,
        padding: EdgeInsets.only(
          top: 12.h,
          left: 12.w,
          right: 12.33.w,
          bottom: 11.91.h,
        ),
        decoration: ShapeDecoration(
          color: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Center(
          child: Icon(Icons.backspace, size: 20.sp),
        ),
      ),
    );
  }

  Widget _buildSettingsButton() {
    return GestureDetector(
      onTap: _handleSettingsPressed,
      child: Container(
        width: 317.33.w,
        height: 121.91.h,
        padding: EdgeInsets.only(
          top: 12.h,
          left: 12.w,
          right: 12.33.w,
          bottom: 11.91.h,
        ),
        decoration: ShapeDecoration(
          color: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Center(
          child: Icon(Icons.settings, size: 28.sp), // Iconița de settings
        ),
      ),
    );
  }
}