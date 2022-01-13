import 'package:flutter/material.dart';
import 'package:flutter_test4/res/custom_colors.dart';
import 'package:flutter_test4/screens/sign_in_screen.dart';


class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '동계현장실습',
          style: TextStyle(
            color: CustomColors.firebaseWhite,
          ),
        ),
      ],
    );
  }
}