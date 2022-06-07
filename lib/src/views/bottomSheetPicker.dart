import 'package:flutter/material.dart';

import '../theme.dart';

void bottomSheetPicker(context,listItem,{required title,required selectItem,onSelect}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          decoration: BoxDecoration(
              color: WHITE, borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                   title,
                    style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                          listItem.length,
                              (i) => ListTile(
                            title: Text(listItem[i],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                            onTap: () => onSelect(listItem[i]),
                          ))),
                ),
              ),
            ],
          )));
}
