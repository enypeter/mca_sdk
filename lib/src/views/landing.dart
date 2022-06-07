
import 'package:flutter/material.dart';
import '../../mca_sdk.dart';
import '../const.dart';
import '../models/response_model.dart';
import '../theme.dart';
import 'auto.dart';
import 'gadget.dart';
import 'health.dart';
import 'travel.dart';

class MyCover extends StatefulWidget {
  const MyCover(
      {Key? key,
        required this.productType,
        required this.productData,
        required this.productId,
        this.accentColor = PRIMARY,
        this.primaryColor = FILL_GREEN,
        required this.userId})
      : super(key: key);
  final TypeOfProduct productType;
  final String productId;
  final String userId;
  final ResponseModel productData;
  final primaryColor;
  final accentColor;

  @override
  State<MyCover> createState() => _MyCoverState();
}

class _MyCoverState extends State<MyCover> {
  ResponseModel? productDetail;

  @override
  void initState() {
    // TODO: implement initState
    fetchProduct();
    super.initState();
  }

  fetchProduct() async {
    productDetail = widget.productData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 15),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: RED.withOpacity(0.2)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.close, color: RED, size: 15),
                      )),
                ),
              ),
            ),
            Expanded(
                child: productDetail == null
                    ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
                    : openProductField(widget.productType)),
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