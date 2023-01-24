// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:manage_app/home/models/family_relationship_model.dart';
import 'package:manage_app/home/ui_view/member_card.dart';
import 'package:manage_app/utils/manage_theme.dart';

class FamilyTreeScreen extends StatefulWidget {
  FamilyTreeScreen({super.key, required this.model});
  FamilyRelationShipModel model;

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  final Graph graph = Graph()..isTree = true;
  SugiyamaConfiguration builder = SugiyamaConfiguration();

  @override
  void initState() {
    for (var element in widget.model.userRealtions!) {
      var fromEmailId = element.parentEmail!;
      var toEmailId = element.childEmail!;
      graph.addEdge(Node.Id(fromEmailId), Node.Id(toEmailId),
          paint: Paint()..color = ManageTheme.nearlyBlack.withOpacity(0.7)..strokeWidth = 1);
    }
    builder
      ..nodeSeparation = (100) .. levelSeparation = (100)
      ..orientation = (SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Family Tree",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
      body: widget.model.users!.isEmpty
          ? Center(
              child: Text(
              "No members added yet!",
              style: ManageTheme.appText(size: 16, weight: FontWeight.w500),
            ))
          : InteractiveViewer(
              boundaryMargin:const EdgeInsets.all(double.infinity),
              minScale: 0.35,
              maxScale: 1,
              child: OverflowBox(
                alignment: Alignment.center,
                minWidth: 0.0,
                minHeight: 0.0,
                maxWidth: double.infinity,
                maxHeight: double.infinity,
                child: GraphView(
                  graph: graph,
                  algorithm: SugiyamaAlgorithm(builder),
                  builder: (node) {
                    var key = node.key!.value;
                    var nodes = widget.model.users!
                        .firstWhere((ele) => ele.email == key);
                    return MemberCard(
                        img_url: nodes.profileImageUrl,
                        name: nodes.fullName!);
                  },
                ),
              )),
    );
  }
}
