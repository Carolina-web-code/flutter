import 'package:core_retail/data/bill/models/line/line_model.dart';
import 'package:core_retail/data/price_list/models/assortment/assortment_model.dart';
import 'package:core_retail/data/price_list/models/assortment/topping_model.dart';
import 'package:core_retail/presentation/restaurant_assortment_preference/bloc/restaurant_assortment_preference_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/order_type_provider.dart';
import 'order.dart';
import 'generated/l10n.dart';

import 'package:kiosk/provider/cart_provider.dart';

class ProductOverlay extends StatefulWidget {
  final AssortmentModel assortment;

  const ProductOverlay({
    super.key,
    required this.assortment,
  });

  @override
  State<ProductOverlay> createState() => _ProductOverlayState();
}

class _ProductOverlayState extends State<ProductOverlay> {
  int quantity = 1;
  List<ToppingModel> selectedToppings = [];


  
  double get totalPrice {
    double basePrice;
    try {
      basePrice = widget.assortment.price??0;
    } catch (e) {
      basePrice = 85.00;
    }

    double toppingsPrice = selectedToppings.fold(0, (sum, topping) => sum + topping.price);
    return quantity * (basePrice + toppingsPrice);
  }

  void _toggleTopping(ToppingModel topping) {
    setState(() {
      if (selectedToppings.any((t) => t.id == topping.id)) {
        selectedToppings.removeWhere((t) => t.id == topping.id);
      } else {
        selectedToppings.add(topping);
      }
    });
  }
  
  @override
  void initState() {
    context.read<RestaurantAssortmentPreferenceBloc>().add(GetRestaurantAssortment(assortmentId:  widget.assortment.id??''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderTypeProvider = Provider.of<OrderTypeProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Semi-transparent background that closes the overlay when tapped
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),

        // Content container
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: screenHeight * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Scrollable content area
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Close button (X)
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: const Text(
                                'x',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Product image
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/desert.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Product name (large)
                        Text(
                          widget.assortment.name??'',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Product description
                        Text(
                          widget.assortment.description??'Ceva descriere',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Arial',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 15),
                        const SizedBox(height: 15),

                        // Static price display
                        Text(
                          '${widget.assortment.price} ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Display current order type
                        Text(
                          orderTypeProvider.isPackage ? S.of(context).pachet : S.of(context).loc,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Quantity controls
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 40,
                              alignment: Alignment.center,
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 50),

                            // Toppings section
                          BlocBuilder<RestaurantAssortmentPreferenceBloc, RestaurantAssortmentPreferenceState>(
                            builder: (context, state) {
                              if(state is RestaurantAssortmentPreferenceLoaded) {
                                final availableToppings = state
                                    .restaurantAssortment.toppings;

                                return Column(
                                  children: availableToppings.map((topping) {
                                    final isSelected = selectedToppings.any((
                                        t) => t.id == topping.id);
                                    final toppingQuantity = isSelected
                                        ? selectedToppings
                                        .where((t) => t.id == topping.id)
                                        .length
                                        : 0;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              topping.name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Arial',
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${topping.price} MDL',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Arial',
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              if(topping.isQuantity)
                                              // Quantity controls for each topping
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (toppingQuantity > 0) {
                                                            selectedToppings.remove(topping);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFFD9D9D9),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 18,
                                                              fontFamily: 'Arial',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Container(
                                                      width: 25,
                                                      height: 25,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        toppingQuantity.toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontFamily: 'Arial',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedToppings.add(topping);
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFFD9D9D9),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 18,
                                                              fontFamily: 'Arial',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if(!topping.isQuantity)
                                              // Checkbox button for non-quantity toppings
                                                GestureDetector(
                                                  onTap: () {
                                                    _toggleTopping(topping);
                                                  },
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: isSelected ? Colors.yellow : const Color(0xFFD9D9D9),
                                                      borderRadius: BorderRadius.circular(4),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: isSelected
                                                          ? const Icon(Icons.check, size: 18, color: Colors.black)
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );

                                  }).toList(),
                                );

                              }else if(state is RestaurantAssortmentPreferenceLoading){
                               return Center(child: CircularProgressIndicator(),);
                              }

                              return SizedBox.shrink();
                            }

                          ),


                        // Space for the fixed button
                      ],
                    ),
                  ),
                ),

                // Fixed OK button at the bottom
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        double basePrice;
                        try {
                          basePrice = widget.assortment.price??0;
                        } catch (e) {
                          basePrice = 85.00;
                        }

                        final toppings = selectedToppings.map((t) => ToppingModel(
                          id: t.id,
                          name: t.name,
                          price: t.price,
                          // image: t.image,
                        )).toList();

                        final cartItem = LineModel(
                          assortment: widget.assortment,
                            quantity: quantity.toDouble(),
                        );

                        Provider.of<CartProvider>(context, listen: false).addToCart(cartItem);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                            ),
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
      ],
    );
  }
}