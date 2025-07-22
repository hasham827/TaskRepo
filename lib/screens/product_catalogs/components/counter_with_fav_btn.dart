import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/colors.dart';

import '../../../providers/fav_provider.dart';
import 'cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {
  int productId;
   CounterWithFavBtn({
    super.key,
     required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CartCounter(),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Icon(
              favoriteProvider.isFavorite(productId)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color:
              favoriteProvider.isFavorite(productId)
                  ? Colors.red
                  : null,
              size: 18,
            ),
          ),
          onTap: () {
            favoriteProvider.toggleFavorite(productId);
          },
        )
      ],
    );
  }
}

