import 'package:flutter/material.dart';
import 'package:task/constants/colors.dart';

import '../../../constants/app_text.dart';

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlinedButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Container(
          width: 50,
          // padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Center(
            child: AppText(
              numOfItems.toString().padLeft(2, '0'),
              size: 20,
              weight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        buildOutlinedButton(
          icon: Icons.add,
          press: () {
            setState(() {
              numOfItems++;
            });
          },
        ),
      ],
    );
  }

  Widget buildOutlinedButton({IconData? icon, Function()? press}) {
    return SizedBox(
      width: 40,
      height: 28,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(0), // Add 8px padding on all sides
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: press,
        child: Center(child: Icon(icon, color: AppColors.txtBlack,size: 18,)),
      ),
    );
  }
}
