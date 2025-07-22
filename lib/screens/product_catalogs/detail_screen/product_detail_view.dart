import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task/constants/app_icons.dart';
import 'package:task/constants/colors.dart';

import '../../../constants/app_const.dart';
import '../../../models/product.dart';
import '../components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product? product;

  const DetailsScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: buildAppBar(context),
      body: Body(product: product!),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bgColor,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: SvgPicture.asset(AppIcons.backIcon, color: AppColors.txtBlack),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppIcons.search, color: AppColors.txtBlack),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppIcons.cart, color: AppColors.txtBlack),
        ),
        SizedBox(width: kDefaultPadding),
      ],
    );
  }
}
