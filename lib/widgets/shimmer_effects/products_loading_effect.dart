import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

class ProductsLoadingEffect extends StatelessWidget {
  final int itemCount; // Number of placeholder cards
  final int crossAxisCount; // Number of columns in the grid
  final double childAspectRatio; // Aspect ratio for grid items

  const ProductsLoadingEffect({
    super.key,
    this.itemCount = 6, // Default to 6 placeholders
    this.crossAxisCount = 2, // Default to 2 columns
    this.childAspectRatio = 0.75, // Adjust based on card height/width
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder:
          (context, index) => SizedBox(
            height: 800,
            child: _buildPlaceholderCard(context),
          ),
    );
  }

  Widget _buildPlaceholderCard(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.2),
      highlightColor: AppColors.grey200.withOpacity(0.6),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(14),
          // color: AppColors.bgColor,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: 80,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 120, height: 18, color: Colors.white),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 60, height: 10, color: Colors.white),
                    Row(
                      children: [
                        Container(width: 16, height: 10, color: Colors.white),
                        SizedBox(width: 4),
                        Container(width: 40, height: 10, color: Colors.white),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
