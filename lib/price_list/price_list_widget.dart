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
  final ScrollController _categoryController = ScrollController();
  bool _showArrow = false;

  @override
  void initState() {
    super.initState();
    // Add a post-frame callback to check if scrolling is needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfScrollNeeded();
    });
  }

  void _checkIfScrollNeeded() {
    if (_categoryController.hasClients) {
      setState(() {
        _showArrow = _categoryController.position.maxScrollExtent > 0;
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    _categoryController.dispose();
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
                priceList =priceList.where((e) => (v.last == (e.parentId ?? ''))).toList();
              }
              return Row(
                children: [
                  // Left side (30%) with categories
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
                                  height: 1.2,
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
                        const SizedBox(height: 20),
                        // Categories section
                        if (categories.isNotEmpty)
                          Container(
                            height: 120,
                            child: Column(
                              children: [
                                Expanded(
                                  child: NotificationListener<ScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification is ScrollEndNotification) {
                                        _checkIfScrollNeeded();
                                      }
                                      return false;
                                    },
                                    child: SingleChildScrollView(
                                      controller: _categoryController,
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: categories.map((category) {
                                          return Container(
                                            width: 70,
                                            margin: const EdgeInsets.symmetric(horizontal: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                _selectId(category.id ?? '');
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: v.contains(category.id)
                                                      ? Colors.yellow
                                                      : Colors.grey[200],
                                                  borderRadius: BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 5,
                                                      offset: const Offset(0, 5),
                                                    ),
                                                  ],
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
                                                      category.name ?? '',
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
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                // Black arrow - only visible if scrolling is possible
                                if (_showArrow)
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                    color: Colors.black, // Changed to black
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Right side (70%) with products
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 8, top: 0),  // top redus
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).mostFavorite,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: 'Arial',
                            ),
                          ),
                          if (v.isNotEmpty)
                            IconButton(
                              onPressed: () {
                                final list = v.sublist(0, v.length - 1);
                                selectedIds.value = list;
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                          Expanded(
                            child: Scrollbar(
                              interactive: true,
                              thumbVisibility: true,
                              controller: scrollController,
                              child: GridView.builder(
                                controller: scrollController,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 70,  // spațiu vertical redus între items
                                 // childAspectRatio: 0.50,
                                ),
                                itemCount: priceList.length,
                                itemBuilder: (_, index) {
                                  final product = priceList[index];
                                  return ProductWidget(
                                    assortment: product,
                                    callback: () => _selectId(product.id ?? ''),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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