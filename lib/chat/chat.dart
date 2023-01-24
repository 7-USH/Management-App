// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/chat/models/ModelProvider.dart';
import 'package:manage_app/chat/models/chat_model.dart';
import 'package:manage_app/chat/screens/chat_screen.dart';
import 'package:manage_app/chat/ui_view/chat_card.dart';
import 'package:manage_app/chat/ui_view/circle_card.dart';
import 'package:manage_app/chat/view_models/users_list_viewmodel.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late FocusNode searchNode;
  String sub_id = "";

  @override
  void initState() {
    getSubID();
    searchNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
  }

  void getSubID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    sub_id = pref.getString("session")!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ManageTheme.nearlyWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0.0,
          title: CupertinoSearchTextField(
            autofocus: false,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            placeholder: "Search by Name/Tag",
            padding: const EdgeInsets.all(10),
            prefixInsets: const EdgeInsets.symmetric(horizontal: 8),
            onChanged: (String value) {},
            onSubmitted: (String value) {},
          ),
        ),
        body: StreamBuilder<QuerySnapshot<User>>(
            stream: context
                .watch<UsersListViewModel>()
                .observeUsers(subscriber_id: sub_id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.items.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Start adding members!",
                          style: ManageTheme.appText(
                              size: screenWidth / 13.5,
                              weight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 37),
                          child: Text(
                            "You can add your family member's, staff's & Guest's from home page and start messaging with them.",
                            textAlign: TextAlign.center,
                            style: ManageTheme.appText(
                                size: screenWidth / 25,
                                weight: FontWeight.w500),
                          )),
                    ],
                  );
                } else {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 90,
                          child: AnimationLimiter(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                          horizontalOffset: 80,
                                          child: FadeInAnimation(
                                              child: CircleCard(
                                            model: snapshot.data!.items[index],
                                          ))));
                                },
                                itemCount: snapshot.data!.items.length),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1.5,
                          color: Colors.grey.withOpacity(0.18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: AnimationLimiter(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.items.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      horizontalOffset: 80,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                            onTap: () {
                                              PersistentNavBarNavigator
                                                  .pushNewScreen(
                                                context,
                                                screen: ChatScreen(
                                                    model: ChatModel(
                                                        image_url: snapshot
                                                            .data!
                                                            .items[index]
                                                            .profile_img_url!,
                                                        last_chat: "Hello",
                                                        name: snapshot.data!
                                                            .items[index].name!,
                                                        time: snapshot
                                                            .data!
                                                            .items[index]
                                                            .updatedAt
                                                            .toString(),
                                                        tag: snapshot.data!
                                                            .items[index].tag!,
                                                        person_phone:
                                                            "7262818443")),
                                                withNavBar: false,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .scale,
                                              );
                                            },
                                            child: ChatCard(
                                                model: snapshot
                                                    .data!.items[index])),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  );
                }
              } else {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ManageTheme.nearlyBlack, size: 35),
                );
              }
            }));
  }
}
