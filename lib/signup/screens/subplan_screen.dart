import 'package:flutter/material.dart';
import 'package:manage_app/app/app.dart';
import 'package:manage_app/home/home.dart';
import 'package:manage_app/signup/models/plan_model.dart';
import 'package:manage_app/signup/ui_view/plan_card.dart';
import 'package:manage_app/utils/manage_theme.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  bool highlight_1 = true;
  bool highlight_2 = false;
  bool highlight_3 = false;
  bool highlight_4 = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ManageTheme.nearlyWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: ManageTheme.nearlyBlack,
          automaticallyImplyLeading: true,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Center(
              child: Text(
                "Choose your plan",
                style: ManageTheme.appText(
                    size: 30, weight: FontWeight.bold, isShadow: false),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          highlight_1 = true;
                          highlight_2 = false;
                          highlight_3 = false;
                          highlight_4 = false;
                        });
                      },
                      child: PlanCard(
                        isHighlighted: highlight_1,
                        model: PlanModel(member_count: "1-25", price: 500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          highlight_1 = false;
                          highlight_3 = false;
                          highlight_4 = false;
                          highlight_2 = true;
                        });
                      },
                      child: PlanCard(
                        isHighlighted: highlight_2,
                        model: PlanModel(member_count: "25-100", price: 1000),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          highlight_1 = false;
                          highlight_3 = true;
                          highlight_4 = false;
                          highlight_2 = false;
                        });
                      },
                      child: PlanCard(
                        isHighlighted: highlight_3,
                        model: PlanModel(member_count: "100-300", price: 1500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          highlight_1 = false;
                          highlight_3 = false;
                          highlight_4 = true;
                          highlight_2 = false;
                        });
                      },
                      child: PlanCard(
                        isHighlighted: highlight_4,
                        model: PlanModel(member_count: "300-500", price: 2000),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const App();
                    }));
                  },
                  style: ManageTheme.buttonStyle(
                    backColor: ManageTheme.nearlyBlack,
                    fontSize: 18,
                  ),
                  child: const Text(
                    "Continue",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
