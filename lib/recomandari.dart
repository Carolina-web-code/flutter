import 'package:core_retail/data/bill/models/line/line_model.dart';
import 'package:core_retail/presentation/restaurant_assortment_preference/bloc/restaurant_assortment_preference_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'meniu.dart';
import 'order.dart';

class RecomandariPage extends StatelessWidget {
  const RecomandariPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 1000 : (isTablet ? 800 : double.infinity),
            ),
            child: Column(
              children: [
                // Top section with logo and texts
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: isDesktop ? 60 : (isTablet ? 50 : 40),
                        left: 40,
                        right: 40,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/pizza_centerblack.png',
                            width: isDesktop ? 100 : (isTablet ? 80 : 70),
                            height: isDesktop ? 100 : (isTablet ? 80 : 70),
                          ),
                          SizedBox(height: isDesktop ? 25 : (isTablet ? 20 : 15)),
                          Text(
                            'Andy\'s recomandă!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isDesktop ? 28 : (isTablet ? 24 : 20),
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                              height: 0.02,
                            ),
                          ),
                          SizedBox(height: isDesktop ? 30 : (isTablet ? 25 : 20)),
                          Text(
                            '"Salmon salad" s-ar combina bine cu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isDesktop ? 22 : (isTablet ? 20 : 16),
                              fontFamily: 'Arial',
                              height: 0.04,
                              letterSpacing: -0.64,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Back button in top left corner
                    // Positioned(
                    //   top: isDesktop ? 120 : (isTablet ? 100 : 110),
                    //   left: 20,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(builder: (context) => const MeniuPage()),
                    //       );
                    //     },
                    //     child: Icon(
                    //       Icons.arrow_back_ios_new,
                    //       size: isDesktop ? 30 : (isTablet ? 28 : 24),
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: isDesktop ? 120 : (isTablet ? 100 : 110),
                    //   right: 20,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(builder: (context) => const OrderPage()),
                    //       );
                    //     },
                    //     child: Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: isDesktop ? 30 : (isTablet ? 28 : 24),
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                // Middle section with recommended items
                Expanded(
                  child: BlocBuilder<RestaurantAssortmentPreferenceBloc, RestaurantAssortmentPreferenceState>(
                    builder: (context, state) {
                      if (state is RestaurantAssortmentPreferenceLoaded) {
                        return GridView.builder(
                          padding: EdgeInsets.all(isDesktop ? 30 : (isTablet ? 25 : 20)),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDesktop ? 2 : 1,
                            childAspectRatio: isDesktop ? 4 : (isTablet ? 5 : 4),
                            crossAxisSpacing: isDesktop ? 20 : 0,
                            mainAxisSpacing: isDesktop ? 20 : (isTablet ? 15 : 10),
                          ),
                          itemCount: state.restaurantAssortment.combinedAssosrtments.length,
                          itemBuilder: (context, index) {
                            final product = state.restaurantAssortment.combinedAssosrtments[index];
                            final cart = Provider.of<CartProvider>(context);
                            final cartItem = cart.items.firstWhere(
                                  (item) => item.assortment.id == product.id,
                              orElse: () => LineModel(assortment: product, quantity: 0),
                            );

                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: isDesktop ? 20 : (isTablet ? 15 : 10),
                                vertical: isDesktop ? 10 : (isTablet ? 8 : 5),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 16 : 12)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Product image
                                    Container(
                                      width: isDesktop ? 100 : (isTablet ? 80 : 60),
                                      height: isDesktop ? 100 : (isTablet ? 80 : 60),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          'assets/chee.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.broken_image, color: Colors.white);
                                          },
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: isDesktop ? 25 : (isTablet ? 20 : 16)),

                                    // Product name and price
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            product.name ?? '',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: isDesktop ? 22 : (isTablet ? 20 : 18),
                                              fontFamily: 'Arial',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: isDesktop ? 10 : (isTablet ? 8 : 6)),
                                          Text(
                                            '${product.price} MDL',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                                              fontFamily: 'Arial',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Quantity controls
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Minus button (white)
                                        Container(
                                          width: isDesktop ? 40 : (isTablet ? 35 : 30),
                                          height: isDesktop ? 40 : (isTablet ? 35 : 30),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: Colors.black),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(Icons.remove,
                                                size: isDesktop ? 24 : (isTablet ? 20 : 18),
                                                color: Colors.black),
                                            onPressed: () {
                                              if (cartItem.quantity > 0) {
                                                if (cartItem.quantity == 1) {
                                                  cart.removeFromCart(product.id ?? '');
                                                } else {
                                                  cart.updateQuantity(
                                                    product.id ?? '',
                                                    (cartItem.quantity - 1).toInt(),
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: isDesktop ? 15 : (isTablet ? 12 : 8)),
                                        // Quantity number
                                        SizedBox(
                                          width: isDesktop ? 40 : (isTablet ? 30 : 25),
                                          child: Center(
                                            child: Text(
                                              cartItem.quantity.toInt().toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: isDesktop ? 22 : (isTablet ? 20 : 18),
                                                fontFamily: 'Arial',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: isDesktop ? 15 : (isTablet ? 12 : 8)),
                                        // Plus button (yellow)
                                        Container(
                                          width: isDesktop ? 40 : (isTablet ? 35 : 30),
                                          height: isDesktop ? 40 : (isTablet ? 35 : 30),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: Colors.black),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(Icons.add,
                                                size: isDesktop ? 24 : (isTablet ? 20 : 18),
                                                color: Colors.black),
                                            onPressed: () {
                                              if (cartItem.quantity == 0) {
                                                cart.addToCart(LineModel(
                                                  assortment: product,
                                                  quantity: 1,
                                                ));
                                              } else {
                                                cart.updateQuantity(
                                                  product.id ?? '',
                                                  (cartItem.quantity + 1).toInt(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is RestaurantAssortmentPreferenceLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),

                // Bottom "Mai târziu" button
                Padding(
                  padding: EdgeInsets.all(isDesktop ? 30 : (isTablet ? 25 : 20)),
                  child: SizedBox(
                    width: isDesktop ? 400 : (isTablet ? 350 : double.infinity),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.yellow,
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const OrderPage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: isDesktop ? 18 : (isTablet ? 16 : 14),
                              horizontal: 30),
                          child: Center(
                            child: Text(
                              'Mai târziu',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: isDesktop ? 26 : (isTablet ? 24 : 22),
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                letterSpacing: -0.64,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}