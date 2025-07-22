import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/app_text.dart';
import 'package:task/constants/colors.dart';
import 'package:task/providers/product_provider.dart';
import 'package:task/screens/product_catalogs/view_all_screen/view_all.dart';
import 'package:task/widgets/product_card_widget.dart';
import 'package:task/widgets/shimmer_effects/products_loading_effect.dart';

class ProductCatalogView extends StatefulWidget {
  const ProductCatalogView({super.key});

  @override
  State<ProductCatalogView> createState() => _ProductCatalogViewState();
}

class _ProductCatalogViewState extends State<ProductCatalogView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      if (productProvider.productsByCategory.isEmpty &&
          !productProvider.isLoading) {
        productProvider.fetchProducts().then((_) {
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              "Hey Emma",
                              size: 20,
                              weight: FontWeight.w600,
                              color: AppColors.txtBlack,
                            ),
                            SizedBox(height: 5),
                            AppText(
                              "Get Ready to Shop",
                              size: 16,
                              weight: FontWeight.w400,
                              color: AppColors.textLightBlack,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.notification_add_rounded,
                                  color: AppColors.skyBlue,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_shopping_cart_sharp,
                                  color: AppColors.skyBlue,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Container(
                      height: Get.height * 0.2,
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              Image.network(
                                fit: BoxFit.fill,
                                "https://i.pinimg.com/736x/b6/89/96/b68996b0aeb13339740f961ada455a77.jpg",
                              ).image,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: Get.height * 0.3,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.only(top: 10),
                child: Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    if (productProvider.isLoading) {
                      return const ProductsLoadingEffect(
                        itemCount: 6,
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      );
                    } else if (productProvider.error != null) {
                      return Center(
                        child: AppText(
                          productProvider.error!,
                          color: Colors.red,
                          size: 16,
                        ),
                      );
                    } else if (productProvider.productsByCategory.isEmpty) {
                      return Center(
                        child: AppText(
                          'No products found',
                          color: AppColors.txtBlack,
                          size: 16,
                        ),
                      );
                    }

                    final categories =
                        productProvider.productsByCategory.keys.toList();
                    return ListView.builder(
                      padding: const EdgeInsets.all(15.0),
                      itemCount: categories.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final products = productProvider.productsByCategory[category]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    category.toUpperCase(),
                                    weight: FontWeight.w600,
                                    size: 18,
                                    color: AppColors.txtBlack,
                                  ),
                                  if(products.length>3)
                                    GestureDetector(
                                    onTap: () {
                                      Get.to(ViewAllProducts(productList: products,));
                                    },
                                    child: AppText(
                                      "View All",
                                      weight: FontWeight.w700,
                                      size: 16,
                                      color: AppColors.skyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 275, // Adjust based on ProductCard height
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount:products.length>3?3:products.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, productIndex) {
                                  return SizedBox(
                                    width: 200, // Adjust based on ProductCard width
                                    child: ProductCard(
                                      product: products[productIndex],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
