import 'package:flutter/material.dart';

import '../const.dart';
import '../theme.dart';
import '../widgets/buttons.dart';
import '../widgets/common.dart';

successScreen(context,{message}) {
  return Center(
    child: Container(
      color: WHITE,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            verticalSpace(),
            Center(
                child: Container(
                    decoration: const BoxDecoration(
                        color: FILL_GREEN, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(checkOut,
                          height: 55, width: 55, package: "mca_sdk"),
                    ))),
            verticalSpace(),
            const   Center(
              child: Text(
             'Purchase Successful',
                style:  TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
              ),
            ),
            verticalSpace(),
             Text(
               message?? 'You have just purchase Auto\nProduct, Kindly Check your email\nto complete your activation',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
            verticalSpace(),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: successButton(
                  text: 'Done',
                  onTap: () => Navigator.pop(context)),

            ),
            smallVerticalSpace(),
          ],
        ),
      ),
    ),
  );
}
