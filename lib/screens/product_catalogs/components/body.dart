import 'package:flutter/material.dart';
import 'package:task/constants/colors.dart';
import 'package:task/screens/product_catalogs/components/product_title_with_image.dart';
import '../../../constants/app_const.dart';
import '../../../models/product.dart';
import 'add_to_cart.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';

class Body extends StatelessWidget {
  final Product? product;

  const Body({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.43),
                padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: kDefaultPadding,
                    right: kDefaultPadding),
                height: 550.0,
                decoration: BoxDecoration(
                  color: AppColors.skyBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    Description(product: product),
                    SizedBox(height: kDefaultPadding / 2),
                    CounterWithFavBtn(productId: product!.id,),
                    SizedBox(height: kDefaultPadding / 1.5),
                    AddToCart(product: product),
                  ],
                ),
              ),
              ProductTitleWithImage(product: product),
            ],
          ),
        ],
      ),
    );
  }
}

