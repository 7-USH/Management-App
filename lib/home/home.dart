// ignore_for_file: prefer_const_constructors, unused_field, sized_box_for_whitespace, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, prefer_final_fields

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/home/models/family_member_model.dart';
import 'package:manage_app/home/models/family_relationship_model.dart';
import 'package:manage_app/home/models/notification_model.dart';
import 'package:manage_app/home/models/task_model.dart';
import 'package:manage_app/home/screens/family_tree.dart';
import 'package:manage_app/home/screens/guest_relation.dart';
import 'package:manage_app/home/screens/notifications.dart';
import 'package:manage_app/home/screens/profile.dart';
import 'package:manage_app/home/screens/staff_tree.dart';
import 'package:manage_app/home/service/home_service.dart';
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
  HomeService service = HomeService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  late Future<FamilyRelationShipModel> _familyRelationShips;

  bool _familyLoader = false;

  final List<String> _family_relations = [
    "Dad",
    "Mom",
    "Son",
    "Daughter",
    "Other",
  ];

  final List<String> _staff_relations = [
    "Manager",
    "Housekeeper",
    "Gardner",
    "Cook",
    "Other",
  ];

  final List<String> _guest_relations = [
    "Home tutor",
    "Friends",
  ];

  String _currentFamilySelectedValue = "Dad";
  String _currentStaffSelectedValue = "Manager";
  String _currentGuestSelectedValue = "Home tutor";

  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    _familyRelationShips = service.getFamilyMembers(context: context);
    super.initState();
  }

  Future<void> addFamilyMembers() async {
    await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return StatefulBuilder(builder: (context, st) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 40),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Add Family Member",
                            style: ManageTheme.insideAppText(
                                size: MediaQuery.of(context).size.width / 18,
                                weight: FontWeight.w700),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              margin: EdgeInsets.only(bottom: 25),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey,
                                    size:
                                        MediaQuery.of(context).size.width / 14,
                                  ),
                                  Text(
                                    "Add Image",
                                    style: ManageTheme.insideAppText(
                                        size:
                                            MediaQuery.of(context).size.width /
                                                43,
                                        weight: FontWeight.w500,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            TextFormField(
                              cursorColor: ManageTheme.nearlyBlack,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter name";
                                }
                                return null;
                              },
                              decoration: ManageTheme.faInputDecoration(
                                hint: "Name",
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: ManageTheme.nearlyBlack,
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter email";
                                } else if (!RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(value)) {
                                  return "Email is not valid";
                                }
                                return null;
                              },
                              decoration: ManageTheme.faInputDecoration(
                                hint: "Email",
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: ManageTheme.faInputDecoration(
                                      hint: "Relation", fontSize: 16),
                                  isEmpty: _currentFamilySelectedValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _currentFamilySelectedValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _currentFamilySelectedValue =
                                              newValue!;
                                          state.didChange(newValue);
                                        });
                                      },
                                      items:
                                          _family_relations.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: ManageTheme.nearlyBlack,
                              controller: bankController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter bank details";
                                }
                                return null;
                              },
                              decoration: ManageTheme.faInputDecoration(
                                hint: "Bank Details",
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: ElevatedButton(
                                  style: ManageTheme.buttonStyle(
                                      backColor: ManageTheme.nearlyBlack),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      st(() {
                                        _familyLoader = true;
                                      });
                                      service
                                          .createFamilyMember(
                                              context: context,
                                              model: FamilyMemberModel(
                                                  email: emailController.text,
                                                  fullName: nameController.text,
                                                  mobileNo: "7262818443",
                                                  address: "Badlapur",
                                                  profile: "family",
                                                  relationTag:
                                                      _currentFamilySelectedValue))
                                          .then((value) {
                                        st(() {
                                          _familyLoader = false;
                                        });
                                        if (value != null) {
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    }
                                  },
                                  child: _familyLoader
                                      ? Center(
                                          child: LoadingAnimationWidget
                                              .staggeredDotsWave(
                                          color: Colors.white,
                                          size: 20,
                                        ))
                                      : Text(
                                          "Add Member",
                                          style: ManageTheme.insideAppText(
                                              size: 15,
                                              weight: FontWeight.w600,
                                              color:
                                                  ManageTheme.backgroundWhite),
                                        )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void addStaffMembers() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add Staff Member",
                        style: ManageTheme.insideAppText(
                            size: MediaQuery.of(context).size.width / 18,
                            weight: FontWeight.w700),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width / 14,
                              ),
                              Text(
                                "Add Image",
                                style: ManageTheme.insideAppText(
                                    size:
                                        MediaQuery.of(context).size.width / 43,
                                    weight: FontWeight.w500,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Name",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Email",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: ManageTheme.faInputDecoration(
                                  hint: "Designation", fontSize: 16),
                              isEmpty: _currentStaffSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentStaffSelectedValue,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _currentStaffSelectedValue = newValue!;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _staff_relations.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Address",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Job Details",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Bank Details",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ElevatedButton(
                              style: ManageTheme.buttonStyle(
                                  backColor: ManageTheme.nearlyBlack),
                              onPressed: () {},
                              child: Text(
                                "Add Member",
                                style: ManageTheme.insideAppText(
                                    size: 15,
                                    weight: FontWeight.w600,
                                    color: ManageTheme.backgroundWhite),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void addGuestMembers() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add Guest Member",
                        style: ManageTheme.insideAppText(
                            size: MediaQuery.of(context).size.width / 18,
                            weight: FontWeight.w700),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width / 14,
                              ),
                              Text(
                                "Add Image",
                                style: ManageTheme.insideAppText(
                                    size:
                                        MediaQuery.of(context).size.width / 43,
                                    weight: FontWeight.w500,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Name",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Email",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: ManageTheme.faInputDecoration(
                                  hint: "Relation", fontSize: 16),
                              isEmpty: _currentGuestSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentGuestSelectedValue,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _currentGuestSelectedValue = newValue!;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _guest_relations.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: ManageTheme.nearlyBlack,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          decoration: ManageTheme.faInputDecoration(
                            hint: "Address",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ElevatedButton(
                              style: ManageTheme.buttonStyle(
                                  backColor: ManageTheme.nearlyBlack),
                              onPressed: () {},
                              child: Text(
                                "Add Member",
                                style: ManageTheme.insideAppText(
                                    size: 15,
                                    weight: FontWeight.w600,
                                    color: ManageTheme.backgroundWhite),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

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
          body: FutureBuilder<FamilyRelationShipModel>(
              future: _familyRelationShips,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Task",
                              style: ManageTheme.insideAppText(
                                  size: screenWidth / 15,
                                  weight: FontWeight.bold),
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
                                            task_message:
                                                "Received Guests by 10:30 AM",
                                            task_number: "${index + 1}."))),
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
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
                                      size: screenWidth / 17,
                                      weight: FontWeight.bold),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: FamilyTreeScreen(
                                          model: snapshot.data!,
                                        ),
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
                                  border: Border.all(
                                      color: ManageTheme.nearlyBlack)),
                              child: AnimationLimiter(
                                child: GridView.count(
                                    key: const PageStorageKey<String>(
                                        'GridView'),
                                    crossAxisCount: 3,
                                    padding: const EdgeInsets.all(10),
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 1.2,
                                    physics: const BouncingScrollPhysics(),
                                    children: List.generate(
                                        snapshot.data!.users!.length, (index) {
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        duration: const Duration(
                                            seconds: 1, milliseconds: 500),
                                        columnCount: 4,
                                        child: SlideAnimation(
                                          horizontalOffset: 80.0,
                                          child: FadeInAnimation(
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  ManageTheme.nearlyBlack,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                      ..add(GestureDetector(
                                        onTap: () {
                                          addFamilyMembers().then((value) =>
                                              setState(() {
                                                _familyRelationShips =
                                                    service.getFamilyMembers(
                                                        context: context);
                                              }));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey.shade400,
                                          child: Icon(
                                            Icons.add,
                                            color: ManageTheme.backgroundWhite,
                                            size: screenWidth / 9,
                                          ),
                                        ),
                                      ))),
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
                                      size: screenWidth / 17,
                                      weight: FontWeight.bold),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                        context,
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
                                  border: Border.all(
                                      color: ManageTheme.nearlyBlack)),
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
                                      duration: const Duration(
                                          seconds: 1, milliseconds: 500),
                                      columnCount: 4,
                                      child: SlideAnimation(
                                        horizontalOffset: 80.0,
                                        child: FadeInAnimation(
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ManageTheme.nearlyBlack,
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                    ..add(GestureDetector(
                                      onTap: () {
                                        addStaffMembers();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade400,
                                        child: Icon(
                                          Icons.add,
                                          color: ManageTheme.backgroundWhite,
                                          size: screenWidth / 9,
                                        ),
                                      ),
                                    )),
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
                                      size: screenWidth / 17,
                                      weight: FontWeight.bold),
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
                                  border: Border.all(
                                      color: ManageTheme.nearlyBlack)),
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
                                      duration: const Duration(
                                          seconds: 1, milliseconds: 500),
                                      columnCount: 4,
                                      child: SlideAnimation(
                                        horizontalOffset: 80.0,
                                        child: FadeInAnimation(
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ManageTheme.nearlyBlack,
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                    ..add(GestureDetector(
                                      onTap: () {
                                        addGuestMembers();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade400,
                                        child: Icon(
                                          Icons.add,
                                          color: ManageTheme.backgroundWhite,
                                          size: screenWidth / 9,
                                        ),
                                      ),
                                    )),
                                ),
                              ),
                            )
                          ]),
                    ),
                  );
                } else {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: ManageTheme.nearlyBlack, size: 35),
                  );
                }
              }),
        ));
  }
}
