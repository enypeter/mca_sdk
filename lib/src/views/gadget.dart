import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const.dart';
import '../theme.dart';
import '../utils/number_format.dart';
import '../utils/validator.dart';
import '../widgets/buttons.dart';
import '../widgets/common.dart';
import '../widgets/input.dart';

class GadgetScreen extends StatefulWidget {
  const GadgetScreen({Key? key}) : super(key: key);

  @override
  State<GadgetScreen> createState() => _GadgetScreenState();
}

class _GadgetScreenState extends State<GadgetScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedTabIndex = 0;
  BodyType bodyType = BodyType.introPage;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final serialController = TextEditingController();
  final typeController = TextEditingController();
  final brandController = TextEditingController();
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
                      child: tabDeco(
                          context, "What we cover", selectedTabIndex, 1)),
                  InkWell(
                      onTap: () => onTabSelected(2),
                      child: tabDeco(
                          context, "Special Condition", selectedTabIndex, 2)),
                ],
              ),
              verticalSpace(),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [howItWorks(), whatCover(), specialCondition()]),
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
                  'You have just purchase Gadget\nProduct, Kindly Check your email\nto complete your activation',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)),
              verticalSpace(),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: successButton(
                    text: 'Done', onTap: () => Navigator.pop(context)),
              ),
              smallVerticalSpace(),
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
              textBoxTitle('Full name'),
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


  List<String> typeOfGadget = ['Laptop', 'Phone', 'Headset', 'TV Set', 'Home Theater'];

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
                            typeOfGadget.length,
                                (i) => ListTile(
                              trailing: typeController.text == typeOfGadget[i]
                                  ? const Icon(Icons.check, color: PRIMARY)
                                  : const SizedBox.shrink(),
                              title: Text(typeOfGadget[i],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                              onTap: () => onSelect(typeOfGadget[i]),
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
                        child: Text('Enter gadget details',
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
                      textBoxTitle('Gadget Type'),
                       InkWell(
                         onTap: () => bottomSheetPicker(context,
                             title: 'Select Type of Gadget', onSelect: (value) {
                               Navigator.pop(context);
                               typeController.text = value;
                             }),
                         child: InputFormField(
                          hint: 'Phone',
                          enabled: false,
                          suffixIcon: const Icon(Icons.expand_more),
                          controller: typeController,
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
                      textBoxTitle('Brand'),
                      InputFormField(
                        hint: 'iPhone X',
                        controller: brandController,
                        validator: (value) => FieldValidator.validate(value),
                      ),
                    ],
                  )),
                ],
              ),
              smallVerticalSpace(),
              textBoxTitle('Serial No.'),
              InputFormField(
                hint: 'GHR893988YBE0',
                textCapitalization: TextCapitalization.words,
                controller: serialController,
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
              textBoxTitle('Gadget Value'),
               InputFormField(hint: '500,000', controller: amountController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  CustomInputFormatter(),
                ],
                onChanged: (string) {
                  if (string.length > 1) {
                    string = formatNumber(string.replaceAll(',', ''));
                    setState(() {
                      amountController.value = TextEditingValue(
                        text: string,
                        selection:
                        TextSelection.collapsed(offset: string.length),
                      );
                    });
                  }
                },
                keyboardType: TextInputType.number,
                validator: (value) => FieldValidator.validate(value),),
              smallVerticalSpace(),
              textBoxTitle('Promo(Optional)'),
               InputFormField(hint: 'GHRE0',              controller: promoController,
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
            textTile('Covers your mobile phone and similar handheld Gadget'),
            verticalSpace(),
            textTile('Your premium is paid annually (i.e pay per year)'),
            verticalSpace(),
            textTile(
                'Once the Claim balance available to you has been paid, this cover ends and is due for renewal.'),
            verticalSpace(),
          ],
        ),
      );

  whatCover() => Container(
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
            textTile('Any Unauthorised repair'),
            verticalSpace(),
            textTile('Wear and tear to your device'),
            verticalSpace(),
            textTile(
                'Other expenses that are not related to the damage screen'),
            verticalSpace(),
            textTile('Repairs due to defect from the manufacturer.'),
            verticalSpace(),
            textTile('Other Exclusion are listed in the policy document'),
          ],
        ),
      );

  specialCondition() => Container(
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
            textTile(
                'Your device should be Inspected by authorised Repair Partner'),
            verticalSpace(),
            textTile(
                'If the parts of your device is not available, we would pay you the cash equivalent to your claim'),
            verticalSpace(),
          ],
        ),
      );
}

enum BodyType { introPage, personalDetail, planDetail, planDetail2, success }
