import 'dart:developer';

import 'package:core_retail/data/price_list/models/assortment/assortment_model.dart';
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
  final selectedIds = ValueNotifier<List<String>>([]);
  final ScrollController scrollController = ScrollController();
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceListBloc, PriceListState>(
      builder: (context, state) {
        if (state is PriceListLoaded) {
          if (state.assortments.isEmpty) {
            return Text('Price list is empty');
          }

          final categories = state.assortments
              .where(
                (e) =>
            (e.parentId == null || e.parentId!.isEmpty) &&
                (e.isFolder ?? false),
          )
              .toList();

          return ValueListenableBuilder<List<String>>(
            valueListenable: selectedIds,
            builder: (context, v, child) {
              List<AssortmentModel> priceList = state.assortments;

              if (v.isNotEmpty) {
                priceList =
                    priceList
                        .where((e) => (v.last == (e.parentId ?? '')))
                        .toList();
              }
              return Row(
                children: [
                  // Left side (30%) with carousel animation
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
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
                                text: S
                                    .of(context)
                                    .what,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Arial',
                                  height: 1.4,
                                  letterSpacing: -0.64,
                                ),
                              ),
                              TextSpan(
                                text: S
                                    .of(context)
                                    .order,
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
                        const SizedBox(height: 20),

                        // Carousel for categories
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return AnimatedBuilder(
                                animation: _pageController,
                                builder: (context, child) {
                                  double value = 1.0;
                                  if (_pageController.position.haveDimensions) {
                                    value = _pageController.page! - index;
                                    value = (1 - (value.abs() * 0.3)).clamp(
                                        0.0, 1.0);
                                  }

                                  return Center(
                                    child: SizedBox(
                                      height: Curves.easeOut.transform(value) *
                                          100,
                                      width: Curves.easeOut.transform(value) *
                                          300,
                                      child: child,
                                    ),
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    _selectId(categories[index].id ?? '');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: v.contains(categories[index].id)
                                          ? Colors.yellow
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
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
                                          categories[index].name ?? '',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Arial',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Page indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            categories.length,
                                (index) =>
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPage == index
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(height: 10),

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

                  // Right side (70%) with hero animations
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 8, top: 20),
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo and "Cele mai Favorite" text
                          const SizedBox(height: 10),
                          Hero(
                            tag: 'favorite-text',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                S
                                    .of(context)
                                    .mostFavorite,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontFamily: 'Arial',
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                          if(v.isNotEmpty)
                            IconButton(onPressed: () {
                              final list = v.sublist(0, v.length-1);

                              selectedIds.value = list;
                            }, icon: Icon(Icons.arrow_back)),
                          // Grid of favorite items (2 columns) with hero animations
                          Expanded(
                            child: Scrollbar(
                              interactive: true,
                              thumbVisibility: true,
                              controller: scrollController,
                              child: GridView.builder(
                                controller: scrollController,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 30,
                                  childAspectRatio: 0.50,
                                ),
                                itemCount: priceList.length,
                                itemBuilder: (_, index) {
                                  final product = priceList[index];
                                  return Hero(
                                    tag: 'product-${product.id}',
                                    child: ProductWidget(assortment: product,
                                      callback: () =>
                                          _selectId(product.id ?? ''),),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return Text('Error');
      },
    );
  }

  void _selectId(String assortmentId) {
    final list = selectedIds.value;

    if (list.contains(assortmentId)) {
      list.remove(assortmentId);
    } else {
      list.add(assortmentId);
    }

    log(selectedIds.value.toList().toString());

    selectedIds.value = [...list];
  }
}