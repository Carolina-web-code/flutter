import 'package:core_retail/data/price_list/models/assortment/assortment_model.dart';
import 'package:flutter/material.dart';
import 'package:proto_definitions/generated/commons.pb.dart';

import '../product_overlay.dart';

class ProductWidget extends StatefulWidget {
  final AssortmentModel assortment;

  const ProductWidget({super.key, required this.assortment, required this.callback});
  final VoidCallback callback;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

      onTap: () {
        if(widget.assortment.isFolder ==false){
        _showProductOverlay(context);}else{
        widget.callback();
        }},

      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 150,
              width: 150,
              child: Image.asset(
                'assets/cheesecake.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    widget.assortment.name??'',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Arial',
                      height: 1,
                    ),
                  ),
                  if(widget.assortment.isFolder ==false)
                  Text(
                    widget.assortment.price?.toStringAsFixed(2)??'0',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Arial',
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductOverlay(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductOverlay(
        assortment: widget.assortment,
      ),
    );

    // if (result != null) {
    //   // Adaugă produsul în coș
    //   print('Added ${result['quantity']} x ${result['product']} for ${result['totalPrice']} MDL');
    //   final cartProvider = Provider.of<CartProvider>(context, listen: false);
    //
    //   // Convertim lista de toppinguri din Map în List<ToppingModel>
    //   final List<ToppingModel> toppings = (result['toppings'] as List<dynamic>).map((toppingMap) {
    //     return ToppingModel(
    //       id: toppingMap['id'],
    //       name: toppingMap['name'],
    //       price: toppingMap['price'],
    //       // image: toppingMap['image'],
    //     );
    //   }).toList();
    //
    //   // Calculează prețul total (inclusiv toppinguri)
    //   final double toppingsPrice = toppings.fold(0.0, (sum, topping) => sum + topping.price);
    //   final double totalUnitPrice = double.parse(result['unitPrice'].toString()) + toppingsPrice;
    //
    //   cartProvider.addToCart(RestaurantLineModel(
    //     productId: result['productId'],
    //     productName: result['product'],
    //     productImage: result['image'],
    //     unitPrice: totalUnitPrice, // Prețul include deja toppingurile
    //     quantity: result['quantity'],
    //     isPackage: result['isPackage'],
    //     toppings: toppings, // Adăugăm lista de toppinguri
    //   ));
    // }
  }
}
