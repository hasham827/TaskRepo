import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/app_icons.dart';
import 'package:task/constants/app_text.dart';
import 'package:task/constants/colors.dart';
import 'package:task/widgets/app_button/app_buttons.dart';

import '../models/product.dart';
import '../providers/fav_provider.dart';
import '../screens/product_catalogs/detail_screen/product_detail_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return GestureDetector(
      onTap: (){
        Get.to(DetailsScreen(product: product,));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(14),
          color: AppColors.bgColor,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      errorBuilder:
                          (context, error, stackTrace) => const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 0,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.bgColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Icon(
                          favoriteProvider.isFavorite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              favoriteProvider.isFavorite(product.id)
                                  ? Colors.red
                                  : null,
                          size: 18,
                        ),
                      ),
                      onTap: () {
                        favoriteProvider.toggleFavorite(product.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  product.title,
                  weight: FontWeight.w500,
                  size: 16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      '\$${product.price.toStringAsFixed(2)}',
                      color: AppColors.txtBlack,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.star, size: 16, color: AppColors.starsColor),
                        AppText(
                          product.rating.toStringAsFixed(1),
                          color: AppColors.txtBlack,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                        AppText(
                          " (${product.ratingCount.toStringAsFixed(0)})",
                          color: AppColors.grey,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppBtn(
                  height: 35,
                  borderColor: AppColors.borderColor,
                  bgColor: Colors.transparent,
                  fontColor: AppColors.txtBlack,
                  onPressed: (){

                  },
                  icon: AppIcons.cartIcon,
                  iconSize: 14,
                  text: "Add to cart",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
