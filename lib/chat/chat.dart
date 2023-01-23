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

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late FocusNode searchNode;

  @override
  void initState() {
    searchNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
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
            stream: context.watch<UsersListViewModel>().observeUsers(
                subscriber_id:
                    "Tushar"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                    duration: const Duration(milliseconds: 500),
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
                                              withNavBar: true,
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation.scale,
                                            );
                                          },
                                          child: ChatCard(
                                              model:
                                                  snapshot.data!.items[index])),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ManageTheme.nearlyBlack, size: 35),
                );
              }
            }));
  }
}
