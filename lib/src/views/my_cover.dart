import 'package:flutter/material.dart';
import 'package:mca_sdk/src/models/response_model.dart';
import '../services/services.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'landing.dart';

enum TypeOfProduct { auto, health, gadget, travel }

class MyCoverLaunch {
  const MyCoverLaunch(
      {Key? key,
      required this.context,
      required this.productType,
      required this.productId,
      this.primaryColor = PRIMARY,
      this.accentColor = FILL_GREEN,
      required this.userId});

  final TypeOfProduct productType;
  final String productId;
  final String userId;
  final BuildContext context;
  final accentColor;
  final primaryColor;

  /// Get settings
  Future<ResponseModel> charge() async {
    showLoading(context, text: 'Initializing MyCover...');
    var response =
        await WebServices.initialiseSdk(userId: userId, productId: productId);
    Navigator.pop(context);

    ResponseModel productData = ResponseModel.fromJson(response);
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCover(
          productType: productType,
          userId: userId,
          productId: productId,
          productData: productData,
          primaryColor: primaryColor,
          accentColor: accentColor,
        ),
      ),
    );
    // }
  }
}
