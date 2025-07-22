import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/constants/app_icons.dart';
import 'package:task/constants/colors.dart';
import 'package:task/widgets/app_button/app_buttons.dart';

import '../../../constants/app_const.dart';
import '../../../models/product.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: kDefaultPadding),
            height: 45.0,
            width: 45.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.cartAddIcon,
                height: 25,
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 45,
              child: AppBtn(
                onPressed: () {},
                text: "Buy Now",
                bgColor: AppColors.bgColor,
                fontColor: AppColors.txtBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
