import 'package:core_retail/presentation/price_list/bloc/price_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/price_list/product_widget.dart';

import '../generated/l10n.dart';

class PriceListWidget extends StatefulWidget {
  final String? parantId;

  const PriceListWidget({super.key, this.parantId});

  @override
  State<PriceListWidget> createState() => _PriceListWidgetState();
}

class _PriceListWidgetState extends State<PriceListWidget> {
  String? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceListBloc, PriceListState>(
      builder: (context, state) {
      if(state is PriceListLoaded){
        final priceList = state.assortments;

        if(priceList.isEmpty){
          return Text('Price list is empty');
        }

        final categories = priceList.where((e)=>(e.parentId == null || e.parentId!.isEmpty) && (e.isFolder??false)).toList();

        return Row(
          children: [
            // Left side (30%)
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/pizza_centerblack.png',
                    height: 50,
                    width: 70,
                  ),
                  const SizedBox(height: 20),
                  // "Ce ai vrea să comanzi?" text
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: S.of(context).what,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Arial',
                            height: 1.4,
                            letterSpacing: -0.64,
                          ),
                        ),
                        TextSpan(
                          text: S.of(context).order,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Arial',
                            height: 1.04,
                            letterSpacing: -0.64,
                          ),
                        ),
                      ],
                    ),
                  ),


                  // 8 SQUARE category items with smooth edges
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategoryId = categories[index].id;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: _selectedCategoryId == categories[index].id
                                  ? Colors.yellow
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                    'assets/freshofsummer.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  categories[index].name??'',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Down arrow icon
                  Center(
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Right side (70%)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.grey[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo and "Cele mai Favorite" text
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).mostFavorite,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontFamily: 'Arial',
                        height: 1,
                      ),
                    ),

                    // Grid of favorite items (2 columns)
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                          childAspectRatio: 0.50,
                        ),
                        itemCount: priceList.length,

                        itemBuilder:(_, index)=> ProductWidget(assortment: priceList[index])
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }

      return Text('Error');}
    );
  }
}
