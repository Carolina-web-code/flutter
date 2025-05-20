import '../generated/l10n.dart';

class MenuTranslations {
  static List<Map<String, dynamic>> getCategories(S l10n) {
    return [
      {'name': l10n.promotions, 'icon': 'assets/freshofsummer.png'},
      {'name': l10n.pizza, 'icon': 'assets/pizza.png'},
      {'name': l10n.breakfast, 'icon': 'assets/mic_dejun.png'},
      {'name': l10n.snacks, 'icon': 'assets/Snacks-uri.png'},
      {'name': l10n.salads, 'icon': 'assets/salate.png'},
      {'name': l10n.drinks, 'icon': 'assets/supe.png'},
      {'name': l10n.dessert, 'icon': 'assets/calde.png'},
      {'name': l10n.sideDishes, 'icon': 'assets/desert.png'},
    ];
  }

  static List<Map<String, dynamic>> getFavoriteItems(S l10n) {
    return [
      {
        'id': '1',
        'name': l10n.summerSalad,
        'price': '65.00 mdl',
        'image': 'assets/cheesecake.png',
        'description': l10n.summerSaladDesc,
      },
      {
        'id': '2',
        'name': l10n.quesadilla,
        'price': '120.00 mdl',
        'image': 'assets/chee.png',
        'description': l10n.quesadillaDesc,
      },
      {
        'id': '3',
        'name': l10n.coolSoup,
        'price': '75.00 mdl',
        'image': 'assets/strawberry.png',
        'description': l10n.coolSoupDesc,
      },
      {
        'id': '4',
        'name': l10n.strawberryCheesecake,
        'price': '45.00 mdl',
        'image': 'assets/cheese.png',
        'description': l10n.strawberryCheesecakeDesc,
      },
      {
        'id': '5',
        'name': l10n.berryCroissant,
        'price': '85.00 mdl',
        'image': 'assets/croasant.png',
        'description': l10n.berryCroissantDesc,
      },
      {
        'id': '6',
        'name': l10n.berryLemonade,
        'price': '35.00 mdl',
        'image': 'assets/vin.png',
        'description': l10n.berryLemonadeDesc,
      },
    ];
  }
}
