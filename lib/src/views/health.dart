import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const.dart';
import '../theme.dart';
import '../utils/validator.dart';
import '../widgets/buttons.dart';
import '../widgets/common.dart';
import '../widgets/input.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedTabIndex = 0;
  BodyType bodyType = BodyType.introPage;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final durationController = TextEditingController();
  final beneficiaryController = TextEditingController();
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
                  'Congrats. An e-HMO ID is being\ngenerated for you. Check your email to\nactivate your e-HMO ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)),
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
    );
  }

  List<String> durationList = ['1 Month', '3 Months', '6 Months', '1 Year'];

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
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            durationList.length,
                            (i) => ListTile(
                                  trailing: durationController.text ==
                                          durationList[i]
                                      ? const Icon(Icons.check, color: PRIMARY)
                                      : const SizedBox.shrink(),
                                  title: Text(durationList[i],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                  onTap: () => onSelect(durationList[i]),
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
                    children: [
                      const Icon(Icons.info, color: GREEN),
                      const SizedBox(width: 15),
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: 'Enter plan details e.g. ',
                              style: TextStyle(fontSize: 12, color: BLACK)),
                          TextSpan(
                              text: ' How long do you want to get covered?',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: BLACK)),
                        ])),
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
                      textBoxTitle('Period of cover'),
                      InkWell(
                        onTap: () => bottomSheetPicker(context,
                            title: 'Select the duration', onSelect: (value) {
                          Navigator.pop(context);
                          durationController.text = value;
                        }),
                        child: InputFormField(
                          hint: '6 month',
                          suffixIcon: const Icon(Icons.expand_more),
                          enabled: false,
                          controller: durationController,
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
                      textBoxTitle('Number of Beneficiary'),
                      InputFormField(
                        hint: '2',
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        controller: beneficiaryController,
                        validator: (value) => FieldValidator.validate(value),
                      ),
                    ],
                  )),
                ],
              ),
              smallVerticalSpace(),
              textBoxTitle('Promo code (Optional)'),
              InputFormField(
                hint: 'GHRE0',
                controller: promoController,
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
            textTile(
                'You will get a Electronic HMO ID generated automatically which is all you need to access healthcare'),
            verticalSpace(),
            textTile(
                'Take your new E-ID to any hospital under this plan, anywhere. You will be attended to like any other person.'),
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
            textTile('Delivery and Antinatal Care'),
            verticalSpace(),
            textTile('Treatment of Everyday Illness,Like malaria e.t.c'),
            verticalSpace(),
            textTile('26 Different types of surgeries'),
            verticalSpace(),
            textTile('And more'),
          ],
        ),
      );
}

enum BodyType { introPage, personalDetail, planDetail, success }
