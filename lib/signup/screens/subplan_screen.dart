// ignore_for_file: unused_field, prefer_final_fields, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/app/app.dart';
import 'package:manage_app/signup/models/plan_model.dart';
import 'package:manage_app/signup/service/signup_service.dart';
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
  bool _isLoading = false;
  late Future<List<PlanModel>> models;
  SignUpService service = SignUpService();

  @override
  void initState() {
    models = service.getSubPlans(context: context);
    super.initState();
  }

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
        body: FutureBuilder<List<PlanModel>>(
            future: models,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
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
                                model: snapshot.data![0],
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
                                model: snapshot.data![1],
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
                                model: snapshot.data![2],
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
                                model: snapshot.data![3],
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
                            setState(() {
                              _isLoading = true;
                            });

                            int idx = 0;
                            if (highlight_1) {
                              idx = 0;
                            } else if (highlight_2) {
                              idx = 1;
                            } else if (highlight_3) {
                              idx = 2;
                            } else if (highlight_4) {
                              idx = 3;
                            }
                            service
                                .createPlan(
                                    context: context,
                                    model: snapshot.data![idx])
                                .then((value) {
                              if (value is AdminPlan) {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const App();
                                }));
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            });
                          },
                          style: ManageTheme.buttonStyle(
                            backColor: ManageTheme.nearlyBlack,
                            fontSize: 18,
                          ),
                          child: _isLoading
                              ? Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 20,
                                ))
                              : const Text(
                                  "Continue",
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ManageTheme.nearlyBlack, size: 35),
                );
              }
            }),
      ),
    );
  }
}
