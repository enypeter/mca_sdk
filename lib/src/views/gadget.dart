import 'package:flutter/material.dart';
import '../const.dart';
import '../theme.dart';
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
    return selectBody(bodyType);
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
              Image.asset(hygeia, height: 24,
                  package: "mca_sdk"),
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
                        child: Image.asset(checkOut, height: 55, width: 55,
                            package: "mca_sdk"),
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
              const InputFormField(hint: 'First name Last name'),
              smallVerticalSpace(),
              textBoxTitle('Email'),
              const InputFormField(hint: 'abc_2002@gmail.com'),
              verticalSpace(),
              verticalSpace(),
              const Divider(),
              verticalSpace(),
              button(
                  text: 'Get Covered',
                  onTap: () => setState(() => bodyType = BodyType.planDetail)),
              smallVerticalSpace(),
              Image.asset(hygeia, height: 24,
                  package: "mca_sdk"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
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
                      textBoxTitle('Gadget Type'),
                      const InputFormField(
                        hint: 'Phone',
                        suffixIcon: const Icon(Icons.expand_more),
                      ),
                    ],
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textBoxTitle('Brand'),
                      const InputFormField(hint: 'iPhone X'),
                    ],
                  )),
                ],
              ),
              smallVerticalSpace(),
              textBoxTitle('Serial No.'),
              const InputFormField(hint: 'GHRE0'),
              verticalSpace(),
              const Divider(),
              verticalSpace(),
              button(
                  text: 'Get Covered',
                  onTap: () => setState(() => bodyType = BodyType.planDetail2)),
              smallVerticalSpace(),
              Image.asset(hygeia, height: 24,
                  package: "mca_sdk"),
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
              const InputFormField(hint: '500,000'),
              smallVerticalSpace(),
              textBoxTitle('Promo(Optional)'),
              const InputFormField(hint: 'GHRE0'),
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
                  onTap: () => setState(() => bodyType = BodyType.success)),
              smallVerticalSpace(),
              Image.asset(hygeia, height: 24,
                  package: "mca_sdk"),
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
                    child: Image.asset(book, height: 25,
                        package: "mca_sdk"))),
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
                    child: Image.asset(insight, height: 25,
                        package: "mca_sdk"))),
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
                    child: Image.asset(layer, height: 25,
                        package: "mca_sdk"))),
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
