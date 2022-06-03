import 'package:flutter/material.dart';
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
            Expanded(child: openProductField(productType)),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/my_cover.png',
                  width: 185, fit: BoxFit.fitWidth),
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
    print('I go there');
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
