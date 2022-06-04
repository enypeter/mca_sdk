import 'package:flutter/material.dart';
import 'package:mca_sdk/src/const.dart';
import '../theme.dart';
import '../views/auto.dart';
import '../views/gadget.dart';
import '../views/health.dart';
import '../views/travel.dart';

enum TypeOfProduct { auto, health, gadget, travel }

class MyCover extends StatelessWidget {
  const MyCover({Key? key, required this.productType}) : super(key: key);
  final TypeOfProduct productType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: RED.withOpacity(0.2)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: RED,
                          size: 15,
                        ),
                      )),
                ),
              ),
            ),
            Expanded(child: openProductField(productType)),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset(myCover,
                  width: 170, fit: BoxFit.fitWidth, package: "mca_sdk"),
            ),
          ],
        ),
      ),
    );
  }

  openProductField(TypeOfProduct productType) {
    switch (productType) {
      case TypeOfProduct.auto:
        return const AutoScreen();
      case TypeOfProduct.health:
        return const HealthScreen();

      case TypeOfProduct.gadget:
        return const GadgetScreen();

      case TypeOfProduct.travel:
        return const TravelScreen();
    }
  }
}

class MyCoverLaunch {
  const MyCoverLaunch(
      {Key? key, required this.productType, required this.context});

  final TypeOfProduct productType;
  final BuildContext context;

  /// Starts Standard Transaction
  charge() async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCover(
          productType: productType,
        ),
      ),
    );
  }
}
