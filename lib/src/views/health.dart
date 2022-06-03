import 'package:flutter/material.dart';
import '../const.dart';
import '../theme.dart';
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
    return  selectBody(bodyType);
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
              Image.asset(hygeia, height: 24),
              const Spacer(),
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
                            height: 55, width: 55),
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
                    onTap: () =>
                        setState(() => bodyType = BodyType.introPage)),
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
              Image.asset(hygeia, height: 24),
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
                      const InputFormField(
                        hint: '6 month',
                        suffixIcon: const Icon(Icons.expand_more),
                      ),
                    ],
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textBoxTitle('Number of Benefiary'),
                      const InputFormField(hint: '2'),
                    ],
                  )),
                ],
              ),
              smallVerticalSpace(),
              textBoxTitle('Promo code (Optional)'),
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
              Image.asset(hygeia, height: 24),
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
                    child: Image.asset(book, height: 25))),
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
                    child: Image.asset(insight, height: 25))),
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
