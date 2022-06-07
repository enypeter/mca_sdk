import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const.dart';
import '../theme.dart';
import '../utils/validator.dart';
import '../widgets/buttons.dart';
import '../widgets/common.dart';
import '../widgets/date_picker.dart';
import '../widgets/input.dart';
import 'success_page.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({Key? key}) : super(key: key);

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedTabIndex = 0;
  BodyType bodyType = BodyType.introPage;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final placeController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final promoController = TextEditingController();
  final amountController = TextEditingController();

  @override
  initState() {
    tabController = TabController(vsync: this, length: 2);
    tabController!.addListener(() {
      setState(() {
        selectedTabIndex = tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  void onTabSelected(int index) {
    tabController!.animateTo(index);
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: selectBody(bodyType));
  }

  selectBody(BodyType bodyType) {
    switch (bodyType) {
      case BodyType.introPage:
        return introBodyScreen();
      case BodyType.personalDetail:
        return personalDetailScreen();
      case BodyType.planDetail:
        return planDetailScreen();
      case BodyType.success:
        return successScreen(
          context,
          message:
          'Congrats. An e-HMO ID is being\ngenerated for you. Check your email to\nactivate your e-HMO ID',


        );
    }
  }

  introBodyScreen() {
    return Center(
      child: Container(
        color: WHITE,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              verticalSpace(),
              TabBar(
                isScrollable: false,
                controller: tabController,
                indicator: const BoxDecoration(color: LIGHT_GREY),
                tabs: <Widget>[
                  InkWell(
                      onTap: () => onTabSelected(0),
                      child: tabDeco(
                          context, "How it works", selectedTabIndex, 0)),
                  InkWell(
                      onTap: () => onTabSelected(1),
                      child: tabDeco(
                          context, "What we cover", selectedTabIndex, 1)),
                ],
              ),
              verticalSpace(),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [howItWorks(), benefits()]),
              ),
              smallVerticalSpace(),
              const Divider(),
              button(
                  text: 'Get Covered',
                  onTap: () =>
                      setState(() => bodyType = BodyType.personalDetail)),
              smallVerticalSpace(),
              Image.asset(hygeia, height: 24, package: "mca_sdk"),
            ],
          ),
        ),
      ),
    );
  }


  personalDetailScreen() {
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
              Container(
                decoration: BoxDecoration(
                    color: FILL_GREEN, borderRadius: BorderRadius.circular(3)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.info, color: GREEN),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                            'Enter details as it appear on legal documents.',
                            style: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                ),
              ),
              verticalSpace(),
              textBoxTitle('Full Name'),
              InputFormField(
                hint: 'First name Last name',
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                validator: (value) => FieldValidator.validate(value),
              ),
              smallVerticalSpace(),
              textBoxTitle('Email'),
              InputFormField(
                hint: 'abc_2002@gmail.com',
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) => EmailValidator.validate(value),
              ),
              verticalSpace(),
              verticalSpace(),
              const Divider(),
              verticalSpace(),
              button(
                  text: 'Get Covered',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => bodyType = BodyType.planDetail);
                    }
                  }),
              smallVerticalSpace(),
              Image.asset(hygeia, height: 24, package: "mca_sdk"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  List<String> countryList = [
    'Australia',
    'Canada',
    'China',
    'England',
    'France',
    'Germany',
    'Ireland',
    'Japan',
    'Maldives',
    'Malaysia',
    'Nigeria',
    'United State of America',
    'United Arab Emirate',
    'Singapore',
  ];

  void bottomSheetPicker(context, {required title, onSelect}) {
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
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            countryList.length,
                            (i) => ListTile(
                                  trailing: placeController.text ==
                                      countryList[i]
                                      ? const Icon(Icons.check, color: PRIMARY)
                                      : const SizedBox.shrink(),
                                  title: Text(countryList[i],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                  onTap: () => onSelect(countryList[i]),
                                ))),
                  ),
                ),
              ],
            )));
  }

  planDetailScreen() {
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
              Container(
                decoration: BoxDecoration(
                    color: FILL_GREEN, borderRadius: BorderRadius.circular(3)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.info, color: GREEN),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                            'Enter details as it appear on legal documents. ',
                            style: TextStyle(fontSize: 12, color: BLACK)),
                      )
                    ],
                  ),
                ),
              ),
              verticalSpace(),
              textBoxTitle('Travelling to'),
              InkWell(
                onTap: () => bottomSheetPicker(context,
                    title: 'Select Country', onSelect: (value) {
                      Navigator.pop(context);
                      placeController.text = value;
                    }),
                child: InputFormField(
                  enabled: false,
                  hint: 'Canada',
                  suffixIcon: const Icon(Icons.expand_more),
                  controller: placeController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) => FieldValidator.validate(value),
                ),
              ),
              smallVerticalSpace(),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textBoxTitle('From'),
                      InkWell(
                        onTap: () {
                          showSelectDatePicker(context, onSelectDate: (value) {
                            Navigator.pop(context);
                            fromDateController.text = DateFormat('dd/MM/yyyy')
                                .format(value)
                                .toString();
                          });
                          if (Platform.isIOS) {
                            fromDateController.text = DateFormat('dd/MM/yyyy')
                                .format(DateTime.now())
                                .toString();
                          }
                        },
                        child: InputFormField(
                          hint: '01/10/2022',
                          enabled: false,
                          suffixIcon: Icon(Icons.event_note_rounded),
                          controller: fromDateController,
                          validator: (value) => FieldValidator.validate(value),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textBoxTitle('To'),
                      InkWell(
                        onTap: () {
                          showSelectDatePicker(context, onSelectDate: (value) {
                            Navigator.pop(context);
                            toDateController.text = DateFormat('dd/MM/yyyy')
                                .format(value)
                                .toString();
                          });
                          if (Platform.isIOS) {
                            toDateController.text = DateFormat('dd/MM/yyyy')
                                .format(DateTime.now())
                                .toString();
                          }
                        },
                        child: InputFormField(
                          enabled: false,
                          hint: '12/10/2022',
                          suffixIcon: const Icon(Icons.event_note_rounded),
                          controller: toDateController,
                          validator: (value) => FieldValidator.validate(value),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              verticalSpace(),
              Container(
                decoration: BoxDecoration(
                    color: FILL_DEEP_GREEN,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                  child: Text(
                    '₦${amountController.text}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
              verticalSpace(),
              const Divider(),
              verticalSpace(),
              button(
                  text: 'Get Covered',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => bodyType = BodyType.success);
                    }
                  }),
              smallVerticalSpace(),
              Image.asset(hygeia, height: 24, package: "mca_sdk"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  howItWorks() => Container(
        color: LIGHT_GREY,
        child: Column(
          children: [
            verticalSpace(),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: GREEN, width: 0.1),
                    shape: BoxShape.circle,
                    color: FILL_GREEN),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(book, height: 25, package: "mca_sdk"))),
            verticalSpace(),
            const Divider(),
            verticalSpace(),
            textTile('Buy a Travel Insurance Plan'),
            verticalSpace(),
            textTile('Provide details'),
            verticalSpace(),
            textTile('Get your Insurance Certificate'),
          ],
        ),
      );

  benefits() => Container(
        color: LIGHT_GREY,
        child: Column(
          children: [
            verticalSpace(),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: GREEN, width: 0.1),
                    shape: BoxShape.circle,
                    color: FILL_GREEN),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:
                        Image.asset(insight, height: 25, package: "mca_sdk"))),
            verticalSpace(),
            const Divider(),
            verticalSpace(),
            textTile('Medical expenses Injury and Illness'),
            verticalSpace(),
            textTile('Excess'),
            verticalSpace(),
            textTile(
                'Medical evacuation, repatriation or transport to medical offline'),
            verticalSpace(),
            textTile('Optical & expenses - Injury'),
            verticalSpace(),
            textTile('Follow up treatment in Nigeria'),
            verticalSpace(),
            textTile('Other cover are listed in the document'),
          ],
        ),
      );
}

enum BodyType { introPage, personalDetail, planDetail, success }
