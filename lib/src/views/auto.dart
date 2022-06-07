import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mca_sdk/src/utils/validator.dart';

import '../const.dart';
import '../theme.dart';
import '../widgets/buttons.dart';
import '../widgets/common.dart';
import '../widgets/input.dart';
import 'bottomSheetPicker.dart';

class AutoScreen extends StatefulWidget {
  const AutoScreen({Key? key}) : super(key: key);

  @override
  State<AutoScreen> createState() => _AutoScreenState();
}

class _AutoScreenState extends State<AutoScreen> with TickerProviderStateMixin {
  TabController? tabController;
  int selectedTabIndex = 0;
  BodyType bodyType = BodyType.introPage;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final typeController = TextEditingController();
  final makeController = TextEditingController();
  final yearController = TextEditingController();
  final plateNumberController = TextEditingController();
  final promoController = TextEditingController();
  final amountController = TextEditingController();

  @override
  initState() {
    tabController = TabController(vsync: this, length: 3);
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
      case BodyType.planDetail2:
        return planDetailScreen2();
      case BodyType.success:
        return successScreen();
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
                      child: tabDeco(context, "Benefits", selectedTabIndex, 1)),
                  InkWell(
                      onTap: () => onTabSelected(2),
                      child: tabDeco(
                          context, "How to Claim", selectedTabIndex, 2)),
                ],
              ),
              verticalSpace(),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [howItWorks(), benefits(), howToClaim()]),
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

  successScreen() {
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
              const Center(
                child: Text(
                  'Purchase Successful',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
              ),
              verticalSpace(),
              const Text(
                  'You have just purchase Auto\nProduct, Kindly Check your email\nto complete your activation',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)),
              verticalSpace(),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: successButton(
                    text: 'Done',
                    onTap: () => setState(() => bodyType = BodyType.introPage)),
              ),
              smallVerticalSpace(),
            ],
          ),
        ),
      ),
    );
  }

  personalDetailScreen() {
    return SingleChildScrollView(
      child: Center(
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
                      color: FILL_GREEN,
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
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
                textBoxTitle('Name of Plan Owner'),
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
      ),
    );
  }

  List<String> typeOfCar = ['Car', 'Wagon', 'SUV', 'Truck', 'Van', 'Trailer'];

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
                        child: Text('Enter vehicle details',
                            style: TextStyle(fontSize: 12, color: BLACK)),
                      )
                    ],
                  ),
                ),
              ),
              verticalSpace(),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textBoxTitle('Vehicle Type'),
                      InkWell(
                        onTap: () => bottomSheetPicker(context, typeOfCar,
                            title: 'Select Type of Car',
                            selectItem: 'typeOfCar[i]',
                            onSelect:(value){typeController.text = value;}),
                        child: InputFormField(
                          hint: 'Car',
                          enabled: false,
                          validator: (value) => FieldValidator.validate(value),
                          suffixIcon: const Icon(Icons.expand_more),
                          controller: typeController,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textBoxTitle('Kind of Vehicle'),
                      InputFormField(
                        hint: 'Toyota',
                        controller: makeController,
                        validator: (value) => FieldValidator.validate(value),
                      ),
                    ],
                  )),
                ],
              ),
              smallVerticalSpace(),
              textBoxTitle('Vehicle Plate No.'),
              InputFormField(
                hint: 'GHR21BC',
                controller: plateNumberController,
                textCapitalization: TextCapitalization.characters,
                validator: (value) => FieldValidator.validate(value),
              ),
              verticalSpace(),
              const Divider(),
              verticalSpace(),
              button(
                  text: 'Get Covered',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => bodyType = BodyType.planDetail2);
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

  planDetailScreen2() {
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
                        child: Text('Enter vehicle details',
                            style: TextStyle(fontSize: 12, color: BLACK)),
                      )
                    ],
                  ),
                ),
              ),
              verticalSpace(),
              textBoxTitle('Vehicle Value'),
              InputFormField(
                hint: '500,000',
                controller: amountController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (value) => FieldValidator.validate(value),
              ),
              smallVerticalSpace(),
              textBoxTitle('Promo(Optional)'),
              InputFormField(
                hint: 'GHRE0',
                controller: promoController,
              ),
              verticalSpace(),
              Container(
                decoration: BoxDecoration(
                    color: FILL_DEEP_GREEN,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                  decoration: const InputDecoration(
                      filled: false, border: InputBorder.none),
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
                    child: Image.asset(
                      book,
                      height: 25,
                      package: "mca_sdk",
                    ))),
            verticalSpace(),
            const Divider(),
            verticalSpace(),
            textTile('Get this Auto Insurance Plan'),
            verticalSpace(),
            textTile('Provide Vehicle Details'),
            verticalSpace(),
            textTile('Get your Insurance Certificate'),
            verticalSpace(),
            textTile('Inspect your vehicle, from anywhere'),
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
            textTile('3rd Party Bodily Injury'),
            verticalSpace(),
            textTile('3rd party Property Damage Up to 1 Million'),
            verticalSpace(),
            textTile('Own Accident Damage'),
            verticalSpace(),
            textTile('Excess Buy Back'),
          ],
        ),
      );

  howToClaim() => Container(
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
                    child: Image.asset(layer, height: 25, package: "mca_sdk"))),
            verticalSpace(),
            const Divider(),
            verticalSpace(),
            textTile('Take pictures of damage'),
            verticalSpace(),
            textTile('Track the progress of your Claim'),
            verticalSpace(),
            textTile('Get paid'),
          ],
        ),
      );
}

enum BodyType { introPage, personalDetail, planDetail, planDetail2, success }
