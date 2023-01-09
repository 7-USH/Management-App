import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:manage_app/chat/models/chat_model.dart';
import 'package:manage_app/chat/screens/chat_screen.dart';
import 'package:manage_app/chat/ui_view/chat_card.dart';
import 'package:manage_app/chat/ui_view/circle_card.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late FocusNode searchNode;

  @override
  void initState() {
    super.initState();
    searchNode = FocusNode();
  }

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
  }

  List<ChatModel> models = [
    ChatModel(
        image_url: "",
        tag: "Father",
        person_phone: "7262818443",
        last_chat: "Hi, nice to meet you. How can I help you Mr.Tushar Mali",
        name: "Soumitra Kand",
        time: "9:34 PM"),
    ChatModel(
        image_url: "",
        tag: "Electrician",
        last_chat: "Hi, nice to meet you. How can I help you Mr.Tushar Mali",
        name: "Tushar Mali",
        person_phone: "7262818443",
        time: "9:34 PM"),
    ChatModel(
        image_url: "",
        tag: "Driver",
        last_chat: "Hi, nice to meet you. How can I help you Mr.Tushar Mali",
        name: "Kashyap Chavhan",
        person_phone: "7262818443",
        time: "9:34 PM"),
    ChatModel(
        image_url: "",
        tag: "Chef",
        last_chat: "Hi, nice to meet you. How can I help you Mr.Tushar Mali",
        name: "Hrishikesh Bade",
        person_phone: "7262818443",
        time: "9:34 PM"),
    ChatModel(
        image_url: "",
        tag: "Cleaner",
        last_chat: "Hi, nice to meet you. How can I help you Mr.Tushar Mali",
        name: "Nirbhay Hanjura",
        person_phone: "7262818443",
        time: "9:34 PM"),
    ChatModel(
        image_url: "",
        tag: "Maid",
        last_chat: "Hi, nice to meet you. How can I help you Mr.Tushar Mali",
        name: "Priya Roy",
        person_phone: "7262818443",
        time: "9:34 PM"),
  ];

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
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
                          child: const SlideAnimation(
                              horizontalOffset: 80,
                              child: FadeInAnimation(child: CircleCard())));
                    },
                    itemCount: 15),
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
                    itemCount: models.length,
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
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: ChatScreen(model: models[index]),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.scale,
                                  );
                                },
                                child: ChatCard(model: models[index])),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
