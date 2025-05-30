// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Licence activation`
  String get sign_in {
    return Intl.message(
      'Licence activation',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Enter your 8-digit license`
  String get opt {
    return Intl.message(
      'Enter your 8-digit license',
      name: 'opt',
      desc: '',
      args: [],
    );
  }

  /// `Test regime`
  String get regim {
    return Intl.message('Test regime', name: 'regim', desc: '', args: []);
  }

  /// `On the spot`
  String get loc {
    return Intl.message('On the spot', name: 'loc', desc: '', args: []);
  }

  /// `Take away`
  String get pachet {
    return Intl.message('Take away', name: 'pachet', desc: '', args: []);
  }

  /// `My Order`
  String get myOrder {
    return Intl.message('My Order', name: 'myOrder', desc: '', args: []);
  }

  /// `What would you like \n to `
  String get what {
    return Intl.message(
      'What would you like \n to ',
      name: 'what',
      desc: '',
      args: [],
    );
  }

  /// `order?`
  String get order {
    return Intl.message('order?', name: 'order', desc: '', args: []);
  }

  /// `Most Favorite`
  String get mostFavorite {
    return Intl.message(
      'Most Favorite',
      name: 'mostFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  /// `Bank card`
  String get card {
    return Intl.message('Bank card', name: 'card', desc: '', args: []);
  }

  /// `  Cash`
  String get num {
    return Intl.message('  Cash', name: 'num', desc: '', args: []);
  }

  /// `Bring your bank card closer to\nthe terminal to complete\nthe payment.`
  String get approveCardMessage {
    return Intl.message(
      'Bring your bank card closer to\nthe terminal to complete\nthe payment.',
      name: 'approveCardMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payment amount`
  String get payment_amount {
    return Intl.message(
      'Payment amount',
      name: 'payment_amount',
      desc: '',
      args: [],
    );
  }

  /// `Card payment`
  String get card_payment {
    return Intl.message(
      'Card payment',
      name: 'card_payment',
      desc: '',
      args: [],
    );
  }

  /// `Cash payment`
  String get cash_payment {
    return Intl.message(
      'Cash payment',
      name: 'cash_payment',
      desc: '',
      args: [],
    );
  }

  /// `Make payment`
  String get make_payment {
    return Intl.message(
      'Make payment',
      name: 'make_payment',
      desc: '',
      args: [],
    );
  }

  /// `Payment initiation error`
  String get payment_init_error {
    return Intl.message(
      'Payment initiation error',
      name: 'payment_init_error',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful`
  String get payment_success {
    return Intl.message(
      'Payment successful',
      name: 'payment_success',
      desc: '',
      args: [],
    );
  }

  /// `Payment error`
  String get payment_error {
    return Intl.message(
      'Payment error',
      name: 'payment_error',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get i {
    return Intl.message('Back', name: 'i', desc: '', args: []);
  }

  /// `Payment`
  String get n {
    return Intl.message('Payment', name: 'n', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Promotions`
  String get promotions {
    return Intl.message('Promotions', name: 'promotions', desc: '', args: []);
  }

  /// `Pizza`
  String get pizza {
    return Intl.message('Pizza', name: 'pizza', desc: '', args: []);
  }

  /// `Breakfast`
  String get breakfast {
    return Intl.message('Breakfast', name: 'breakfast', desc: '', args: []);
  }

  /// `Snacks`
  String get snacks {
    return Intl.message('Snacks', name: 'snacks', desc: '', args: []);
  }

  /// `Salads`
  String get salads {
    return Intl.message('Salads', name: 'salads', desc: '', args: []);
  }

  /// `Drinks`
  String get drinks {
    return Intl.message('Drinks', name: 'drinks', desc: '', args: []);
  }

  /// `Dessert`
  String get dessert {
    return Intl.message('Dessert', name: 'dessert', desc: '', args: []);
  }

  /// `Side dishes`
  String get sideDishes {
    return Intl.message('Side dishes', name: 'sideDishes', desc: '', args: []);
  }

  /// `SUMMER SALAD`
  String get summerSalad {
    return Intl.message(
      'SUMMER SALAD',
      name: 'summerSalad',
      desc: '',
      args: [],
    );
  }

  /// `A healthy and juicy summer salad of oven-baked vegetables with chicken and a special dressing.`
  String get summerSaladDesc {
    return Intl.message(
      'A healthy and juicy summer salad of oven-baked vegetables with chicken and a special dressing.',
      name: 'summerSaladDesc',
      desc: '',
      args: [],
    );
  }

  /// `QUESADILLA`
  String get quesadilla {
    return Intl.message('QUESADILLA', name: 'quesadilla', desc: '', args: []);
  }

  /// `The hit of Mexican cuisine - a very aromatic and satisfying crispy quesadilla with pieces of chicken fillet in a thick sauce, tomatoes and bell peppers.`
  String get quesadillaDesc {
    return Intl.message(
      'The hit of Mexican cuisine - a very aromatic and satisfying crispy quesadilla with pieces of chicken fillet in a thick sauce, tomatoes and bell peppers.',
      name: 'quesadillaDesc',
      desc: '',
      args: [],
    );
  }

  /// `COOL SOUP`
  String get coolSoup {
    return Intl.message('COOL SOUP', name: 'coolSoup', desc: '', args: []);
  }

  /// `What could be tastier than classic cold okroshka on a hot summer day?! Refreshing okroshka made with kefir, fresh cucumbers and radishes - the ideal soup for a healthy lunch.`
  String get coolSoupDesc {
    return Intl.message(
      'What could be tastier than classic cold okroshka on a hot summer day?! Refreshing okroshka made with kefir, fresh cucumbers and radishes - the ideal soup for a healthy lunch.',
      name: 'coolSoupDesc',
      desc: '',
      args: [],
    );
  }

  /// `STRAWBERRY CHEESECAKE`
  String get strawberryCheesecake {
    return Intl.message(
      'STRAWBERRY CHEESECAKE',
      name: 'strawberryCheesecake',
      desc: '',
      args: [],
    );
  }

  /// `Light mascarpone mousse, seasonal fruits drizzled with strawberry sauce.`
  String get strawberryCheesecakeDesc {
    return Intl.message(
      'Light mascarpone mousse, seasonal fruits drizzled with strawberry sauce.',
      name: 'strawberryCheesecakeDesc',
      desc: '',
      args: [],
    );
  }

  /// `BERRY CROISSANT`
  String get berryCroissant {
    return Intl.message(
      'BERRY CROISSANT',
      name: 'berryCroissant',
      desc: '',
      args: [],
    );
  }

  /// `An original serving - classic croissant with salted caramel ice cream, wild berry sauce and seasonal fruits.`
  String get berryCroissantDesc {
    return Intl.message(
      'An original serving - classic croissant with salted caramel ice cream, wild berry sauce and seasonal fruits.',
      name: 'berryCroissantDesc',
      desc: '',
      args: [],
    );
  }

  /// `BERRY LEMONADE`
  String get berryLemonade {
    return Intl.message(
      'BERRY LEMONADE',
      name: 'berryLemonade',
      desc: '',
      args: [],
    );
  }

  /// `And what could be better on a hot summer day than a refreshing drink?!`
  String get berryLemonadeDesc {
    return Intl.message(
      'And what could be better on a hot summer day than a refreshing drink?!',
      name: 'berryLemonadeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Extra Mozzarella`
  String get extraMozzarella {
    return Intl.message(
      'Extra Mozzarella',
      name: 'extraMozzarella',
      desc: '',
      args: [],
    );
  }

  /// `Pepperoni`
  String get pepperoni {
    return Intl.message('Pepperoni', name: 'pepperoni', desc: '', args: []);
  }

  /// `Mushrooms`
  String get mushrooms {
    return Intl.message('Mushrooms', name: 'mushrooms', desc: '', args: []);
  }

  /// `Olives`
  String get olives {
    return Intl.message('Olives', name: 'olives', desc: '', args: []);
  }

  /// `Peppers`
  String get peppers {
    return Intl.message('Peppers', name: 'peppers', desc: '', args: []);
  }

  /// `Additional Whipped Cream`
  String get additionalWhippedCream {
    return Intl.message(
      'Additional Whipped Cream',
      name: 'additionalWhippedCream',
      desc: '',
      args: [],
    );
  }

  /// `Berries`
  String get berries {
    return Intl.message('Berries', name: 'berries', desc: '', args: []);
  }

  /// `Caramelized Nuts`
  String get caramelizedNuts {
    return Intl.message(
      'Caramelized Nuts',
      name: 'caramelizedNuts',
      desc: '',
      args: [],
    );
  }

  /// `Lemon Cream`
  String get lemonCream {
    return Intl.message('Lemon Cream', name: 'lemonCream', desc: '', args: []);
  }

  /// `Extra Chicken`
  String get extraChicken {
    return Intl.message(
      'Extra Chicken',
      name: 'extraChicken',
      desc: '',
      args: [],
    );
  }

  /// `Extra Croutons`
  String get extraCroutons {
    return Intl.message(
      'Extra Croutons',
      name: 'extraCroutons',
      desc: '',
      args: [],
    );
  }

  /// `Boiled Egg`
  String get boiledEgg {
    return Intl.message('Boiled Egg', name: 'boiledEgg', desc: '', args: []);
  }

  /// `Feta Cheese`
  String get fetaCheese {
    return Intl.message('Feta Cheese', name: 'fetaCheese', desc: '', args: []);
  }

  /// `Vanilla Ice Cream`
  String get vanillaIceCream {
    return Intl.message(
      'Vanilla Ice Cream',
      name: 'vanillaIceCream',
      desc: '',
      args: [],
    );
  }

  /// `Chocolate Syrup`
  String get chocolateSyrup {
    return Intl.message(
      'Chocolate Syrup',
      name: 'chocolateSyrup',
      desc: '',
      args: [],
    );
  }

  /// `Oreo Cookie Pieces`
  String get oreoCookiePieces {
    return Intl.message(
      'Oreo Cookie Pieces',
      name: 'oreoCookiePieces',
      desc: '',
      args: [],
    );
  }

  /// `Coconut Flakes`
  String get coconutFlakes {
    return Intl.message(
      'Coconut Flakes',
      name: 'coconutFlakes',
      desc: '',
      args: [],
    );
  }

  /// `Whipped Cream`
  String get whippedCream {
    return Intl.message(
      'Whipped Cream',
      name: 'whippedCream',
      desc: '',
      args: [],
    );
  }

  /// `Vanilla Flavor`
  String get vanillaFlavor {
    return Intl.message(
      'Vanilla Flavor',
      name: 'vanillaFlavor',
      desc: '',
      args: [],
    );
  }

  /// `Tapioca Pearls`
  String get tapiocaPearls {
    return Intl.message(
      'Tapioca Pearls',
      name: 'tapiocaPearls',
      desc: '',
      args: [],
    );
  }

  /// `Caramel Cream`
  String get caramelCream {
    return Intl.message(
      'Caramel Cream',
      name: 'caramelCream',
      desc: '',
      args: [],
    );
  }

  /// `Inactivity Detected`
  String get inactivityTitle {
    return Intl.message(
      'Inactivity Detected',
      name: 'inactivityTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to clear your cart and start over?`
  String get inactivityMessage {
    return Intl.message(
      'Do you want to clear your cart and start over?',
      name: 'inactivityMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
