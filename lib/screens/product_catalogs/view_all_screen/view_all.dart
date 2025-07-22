import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/colors.dart';

import '../../../constants/app_text.dart';
import '../../../models/product.dart';
import '../../../providers/product_provider.dart';
import '../../../widgets/product_card_widget.dart';

class ViewAllProducts extends StatefulWidget {
  final List<Product> productList;

  const ViewAllProducts({super.key, required this.productList});

  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.productList;
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          widget.productList.where((product) {
            return product.title.toLowerCase().contains(query) ||
                product.category.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          '${widget.productList.first.category.capitalize}',
          size: 22,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.skyBlue,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        bottom: true,
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return _filteredProducts.isEmpty
                ? Center(child: AppText("No Search Result Found",size: 22))
                : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: _filteredProducts[index]);
                  },
                );
          },
        ),
      ),
    );
  }
}
