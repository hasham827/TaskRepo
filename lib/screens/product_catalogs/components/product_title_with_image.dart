import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/constants/colors.dart';

import '../../../constants/app_const.dart';
import '../../../constants/app_text.dart';
import '../../../models/product.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            product!.category.capitalize!,
            color: AppColors.txtBlack,
            size: 18,
          ),
          SizedBox(height: 10),
          AppText(
            product!.title,
            color: AppColors.txtBlack,
            weight: FontWeight.w600,
            size: 22,
          ),
          SizedBox(height: kDefaultPadding),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Price\n',
                      style: TextStyle(
                        color: AppColors.txtBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '\$${product!.price}',
                      style: TextStyle(
                        color: AppColors.txtBlack,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Hero(
                  tag: '${product!.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    // Rounded corners
                    child: CachedNetworkImage(
                      imageUrl: product!.image,
                      fit: BoxFit.fill,
                      height: 350,
                      width: 350,
                      // color: Colors.transparent,
                      placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: AppColors.borderColor.withOpacity(0.2),
                            highlightColor: AppColors.bgColor.withOpacity(0.4),
                            child: Container(
                              height: 350,
                              width: 350,
                              color: Colors.white, // Shimmer base color
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
