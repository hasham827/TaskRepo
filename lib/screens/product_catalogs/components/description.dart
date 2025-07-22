import 'package:flutter/material.dart';

import '../../../constants/app_const.dart';
import '../../../constants/app_text.dart';
import '../../../constants/colors.dart';
import '../../../models/product.dart';

class Description extends StatelessWidget {
  const Description({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: AppText(product!.description,color: AppColors.bgColor,size: 16,weight: FontWeight.w400),
    );
  }
}
