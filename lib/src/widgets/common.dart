import 'package:flutter/material.dart';
import 'package:mca_sdk/src/widgets/buttons.dart';

import '../theme.dart';

snackBar(message) =>
    SnackBar(content: Text(message), backgroundColor: Colors.red);

SizedBox smallVerticalSpace() => const SizedBox(height: 10);

SizedBox verticalSpace() => const SizedBox(height: 20);

Row textTile(text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(width: 10),
      const Padding(
        padding: EdgeInsets.all(5.0),
        child: Icon(Icons.circle, color: PRIMARY, size: 10),
      ),
      const SizedBox(width: 15),
      Expanded(
          child: Text(
        text,
        textAlign: TextAlign.start,
      ))
    ],
  );
}

Padding tabDeco(BuildContext context, title, selectedTabIndex, index) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Center(
      child: Text(title,
          style: TextStyle(
              fontSize: 11,
              fontWeight:
                  selectedTabIndex == index ? FontWeight.w600 : FontWeight.w400,
              color: selectedTabIndex == index ? PRIMARY : BLACK)),
    ),
  );
}

Future<void> showLoading(context, {text}) async {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          contentPadding: const EdgeInsets.all(20),
          backgroundColor: Colors.transparent,
          content: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Center(
                            child: CircularProgressIndicator(color: PRIMARY)),
                        const SizedBox(height: 20),
                        Text(text,
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> showFailedDialog(context,
    {message}) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Wrap(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    verticalSpace(),
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle,color: RED.withOpacity(0.1)),
                      child:const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Center(
                            child: Icon(Icons.cancel_outlined,
                                color: RED, size: 35)),
                      ),
                    ),

                    verticalSpace(),
                    const Center(
                      child: Text(
                        'Failed',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                    ),
                    verticalSpace(),
                     Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16)),
                    verticalSpace(),
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: successButton(
                          text: 'Cancel',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }),
                    ),
                    smallVerticalSpace(),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
