// ignore_for_file: prefer_const_constructors, unused_field, sized_box_for_whitespace, use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manage_app/home/models/notification_model.dart';
import 'package:manage_app/home/models/task_model.dart';
import 'package:manage_app/home/screens/family_tree.dart';
import 'package:manage_app/home/screens/guest_relation.dart';
import 'package:manage_app/home/screens/notifications.dart';
import 'package:manage_app/home/screens/profile.dart';
import 'package:manage_app/home/screens/staff_tree.dart';
import 'package:manage_app/home/ui_view/task_card.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: ManageTheme.nearlyWhite,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: CupertinoSearchTextField(
                      autofocus: false,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      placeholder: "Search by Name/Tag",
                      padding: EdgeInsets.all(10),
                      prefixInsets: EdgeInsets.symmetric(horizontal: 8),
                      onChanged: (String value) {},
                      onSubmitted: (String value) {},
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: NotificationsScreen(
                        models: [
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message: "Your Leave is Approved",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message:
                                  "Your Leave is Approved fsfsfsfsfsfsfsf afqfaf",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message: "Your Leave is Approved",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message:
                                  "Your Leave is Approved fsfsfsfsfsfsfsf afqfaf",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message: "Your Leave is Approved",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message:
                                  "Your Leave is Approved fsfsfsfsfsfsfsf afqfaf",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message: "Your Leave is Approved",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message:
                                  "Your Leave is Approved fsfsfsfsfsfsfsf afqfaf",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message: "Your Leave is Approved",
                              owner_image: "",
                              owner_name: "Tushar Mali"),
                          NotificationModel(
                              date: "Jun 28, 2022",
                              notify_message:
                                  "Your Leave is Approved fsfsfsfsfsfsfsf afqfaf",
                              owner_image: "",
                              owner_name: "Tushar Mali")
                        ],
                      ),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.scale,
                    );
                  },
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.grey,
                    size: screenWidth / 13,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ProfileScreen(),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.scale,
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: ManageTheme.nearlyBlack,
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Task",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 15, weight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                        carouselController: buttonCarouselController,
                        items: List.generate(
                            10,
                            (index) => TaskCard(
                                isCurrent: index == _current,
                                model: TaskModel(
                                    task_given_by: "Tushar Mali",
                                    task_message: "Received Guests by 10:30 AM",
                                    task_number: "${index + 1}."))),
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.32,
                          aspectRatio: 1,
                          viewportFraction: 0.6,
                          padEnds: true,
                          disableCenter: true,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                          reverse: false,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Family Members",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 17, weight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: FamilyTreeScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.scale);
                          },
                          icon: Icon(FontAwesomeIcons.peopleRoof),
                          iconSize: screenWidth / 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ManageTheme.nearlyBlack)),
                      child: AnimationLimiter(
                        child: GridView.count(
                          key: const PageStorageKey<String>('GridView'),
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(10),
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.2,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(10, (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration:
                                  const Duration(seconds: 1, milliseconds: 500),
                              columnCount: 4,
                              child: SlideAnimation(
                                horizontalOffset: 80.0,
                                child: FadeInAnimation(
                                  child: CircleAvatar(
                                    backgroundColor: ManageTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Staff Members",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 17, weight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: StaffTreeScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.scale);
                          },
                          icon: Icon(FontAwesomeIcons.peopleGroup),
                          iconSize: screenWidth / 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ManageTheme.nearlyBlack)),
                      child: AnimationLimiter(
                        child: GridView.count(
                          key: const PageStorageKey<String>('GridView'),
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(10),
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.2,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(10, (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration:
                                  const Duration(seconds: 1, milliseconds: 500),
                              columnCount: 4,
                              child: SlideAnimation(
                                horizontalOffset: 80.0,
                                child: FadeInAnimation(
                                  child: CircleAvatar(
                                    backgroundColor: ManageTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Guests",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 17, weight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: GuestRelationScreen(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.scale,
                            );
                          },
                          icon: Icon(FontAwesomeIcons.peopleArrows),
                          iconSize: screenWidth / 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ManageTheme.nearlyBlack)),
                      child: AnimationLimiter(
                        child: GridView.count(
                          key: const PageStorageKey<String>('GridView'),
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(10),
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.2,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(10, (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration:
                                  const Duration(seconds: 1, milliseconds: 500),
                              columnCount: 4,
                              child: SlideAnimation(
                                horizontalOffset: 80.0,
                                child: FadeInAnimation(
                                  child: CircleAvatar(
                                    backgroundColor: ManageTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
