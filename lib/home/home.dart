// ignore_for_file: prefer_const_constructors, unused_field, sized_box_for_whitespace, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, prefer_final_fields, must_be_immutable, unrelated_type_equality_checks, unnecessary_null_comparison

import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:manage_app/chat/view_models/users_list_viewmodel.dart';
import 'package:manage_app/home/models/family_member_model.dart';
import 'package:manage_app/home/models/family_relationship_model.dart';
import 'package:manage_app/home/models/notification_model.dart';
import 'package:manage_app/home/models/profile_detail_model.dart';
import 'package:manage_app/home/screens/family_tree.dart';
import 'package:manage_app/home/screens/guest_relation.dart';
import 'package:manage_app/home/screens/notifications.dart';
import 'package:manage_app/home/screens/profile.dart';
import 'package:manage_app/home/screens/staff_tree.dart';
import 'package:manage_app/home/screens/task_detail_screen.dart';
import 'package:manage_app/home/service/home_service.dart';
import 'package:manage_app/home/ui_view/task_card.dart';
import 'package:manage_app/task/models/display_task_model.dart';
import 'package:manage_app/task/service/task_service.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.model});
  ProfileDetailModel model;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  HomeService service = HomeService();
  TaskService taskService = TaskService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  late Future<FamilyRelationShipModel> _familyRelationShips;
  bool _familyLoader = false;
  String _currentFamilySelectedValue = "Dad";
  String _currentStaffSelectedValue = "Manager";
  String _currentGuestSelectedValue = "Home tutor";
  CarouselController buttonCarouselController = CarouselController();
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
  StreamController<List<DisplayStaffTaskModel>> _controller =
      StreamController();
  Timer? _timer;

  @override
  void initState() {
    _familyRelationShips = service.getFamilyMembers(context: context);
    if (widget.model.profile == "staff") {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) {
        getCurrentTasks().onError((error, stackTrace) {
          closeStream();
          timer.cancel();
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null && mounted) {
      _timer!.cancel();
      closeStream();
    }
    super.dispose();
  }

  void closeStream() async {
    await _controller.close();
  }

  Future<void> getCurrentTasks() async {
    try {
      List<DisplayStaffTaskModel> models =
          await taskService.getStaffTasks(context: context);
      _controller.sink.add(models);
    } catch (e) {
      throw e.toString();
    }
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
            return ChangeNotifierProvider<UsersListViewModel>(
                create: (_) => UsersListViewModel(),
                builder: (context, child) {
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
                                      size: MediaQuery.of(context).size.width /
                                          18,
                                      weight: FontWeight.w700),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width / 3,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    margin: EdgeInsets.only(bottom: 25),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          color: Colors.grey,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                        ),
                                        Text(
                                          "Add Image",
                                          style: ManageTheme.insideAppText(
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
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
                                        decoration:
                                            ManageTheme.faInputDecoration(
                                                hint: "Relation", fontSize: 16),
                                        isEmpty:
                                            _currentFamilySelectedValue == '',
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
                                            items: _family_relations
                                                .map((String value) {
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            st(() {
                                              _familyLoader = true;
                                            });
                                            service
                                                .createFamilyMember(
                                                    context: context,
                                                    model: FamilyMemberModel(
                                                        email: emailController
                                                            .text,
                                                        fullName:
                                                            nameController.text,
                                                        mobileNo: "7262818443",
                                                        address: "Badlapur",
                                                        profile: "family",
                                                        relationTag:
                                                            _currentFamilySelectedValue))
                                                .then((value) {
                                              st(() {
                                                _familyLoader = false;
                                              });
                                              if (value) {
                                                context
                                                    .read<UsersListViewModel>()
                                                    .addUser(
                                                        tag:
                                                            _currentFamilySelectedValue,
                                                        email: emailController
                                                            .text,
                                                        profile_image_url: "",
                                                        index: 1,
                                                        name:
                                                            nameController.text,
                                                        is_online: false)
                                                    .then((value) =>
                                                        Navigator.of(context)
                                                            .pop());
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
                                                style:
                                                    ManageTheme.insideAppText(
                                                        size: 15,
                                                        weight: FontWeight.w600,
                                                        color: ManageTheme
                                                            .backgroundWhite),
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
                      screen: ProfileScreen(
                        model: widget.model,
                      ),
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
                            StreamBuilder<List<DisplayStaffTaskModel>>(
                                stream: _controller.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return snapshot.data!.isEmpty
                                        ? SizedBox(
                                            height: screenHeight / 3.4,
                                            child: Chip(
                                              label: Center(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  LottieBuilder.asset(
                                                    "assets/gifs/task.json",
                                                    frameRate: FrameRate.max,
                                                    repeat: false,
                                                    height: 150,
                                                  ),
                                                  Text(
                                                    "No Task for Today!",
                                                    style: ManageTheme
                                                        .insideAppText(
                                                            size: screenWidth /
                                                                24,
                                                            weight: FontWeight
                                                                .w500),
                                                  )
                                                ],
                                              )),
                                            ),
                                          )
                                        : CarouselSlider(
                                            carouselController:
                                                buttonCarouselController,
                                            items: List.generate(
                                                snapshot.data!.length,
                                                (index) => GestureDetector(
                                                      onTap: () {
                                                        PersistentNavBarNavigator
                                                            .pushNewScreen(
                                                          context,
                                                          screen:
                                                              TaskDetailScreen(
                                                            model: snapshot
                                                                .data![index],
                                                          ),
                                                          withNavBar: true,
                                                          pageTransitionAnimation:
                                                              PageTransitionAnimation
                                                                  .scale,
                                                        );
                                                      },
                                                      child: TaskCard(
                                                          index: (index + 1)
                                                              .toString(),
                                                          isCurrent:
                                                              index == _current,
                                                          model: snapshot
                                                              .data![index]),
                                                    )),
                                            options: CarouselOptions(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.32,
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
                                            ));
                                  } else {
                                    return CarouselSlider(
                                        carouselController:
                                            buttonCarouselController,
                                        items: List.generate(
                                            5,
                                            (index) => Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor: ManageTheme
                                                      .nearlyGrey
                                                      .withOpacity(0.5),
                                                  direction:
                                                      ShimmerDirection.rtl,
                                                  child: TaskCard(
                                                      isCurrent: true,
                                                      index: "",
                                                      model:
                                                          DisplayStaffTaskModel(
                                                              priority: "",
                                                              validFor: 3,
                                                              validFrom: "",
                                                              taskTitle: "",
                                                              description: "",
                                                              status: "",
                                                              id: "",
                                                              assignedAt: "")),
                                                )),
                                        options: CarouselOptions(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.32,
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
                                        ));
                                  }
                                }),
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
                                      ..add(widget.model.profile == "staff"
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                addFamilyMembers().then(
                                                    (value) => setState(() {
                                                          _familyRelationShips =
                                                              service.getFamilyMembers(
                                                                  context:
                                                                      context);
                                                        }));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                                child: Icon(
                                                  Icons.add,
                                                  color: ManageTheme
                                                      .backgroundWhite,
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
                                    ..add(widget.model.profile == "staff"
                                        ? SizedBox()
                                        : GestureDetector(
                                            onTap: () {
                                              addStaffMembers();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade400,
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    ManageTheme.backgroundWhite,
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
                                    ..add(widget.model.profile == "staff"
                                        ? SizedBox()
                                        : GestureDetector(
                                            onTap: () {
                                              addGuestMembers();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade400,
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    ManageTheme.backgroundWhite,
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
