import 'package:flutter/material.dart';
import '../common/app_responsive.dart';

import 'package:provider/provider.dart';
import '../providers/node_provider.dart';
import '../models/noode.dart';
import 'dart:math';

import 'package:graphview/GraphView.dart';
import '/common/app_colors.dart';

class TreeWidget extends StatefulWidget {
  const TreeWidget();

  @override
  _TreeWidgetState createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  Graph graph = Graph()..isTree = true;
  List<Noode> _tree = [];
  bool _isLeading = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  Random r = Random();
  int selectedNode;
  @override
  Widget build(BuildContext context) {
    builder.orientation = 3;

    return _isLeading
        ? Center(child: CircularProgressIndicator())
        : Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.bgSideMenu,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.yellow,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.only(left: 20, bottom: 5, right: 20),
                  child: Row(
                    children: [
                      Container(
                        width: AppResponsive.isDesktop(context) ? 100 : 50,
                        child: TextFormField(
                          initialValue: builder.siblingSeparation.toString(),
                          decoration: InputDecoration(
                              labelText: "Sibling Separation",
                              labelStyle:
                                  TextStyle(color: AppColor.bgSideMenu)),
                          onChanged: (text) {
                            builder.siblingSeparation =
                                int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                          width: AppResponsive.isDesktop(context) ? 10 : 3),
                      Container(
                        width: AppResponsive.isDesktop(context) ? 100 : 50,
                        child: TextFormField(
                          initialValue: builder.levelSeparation.toString(),
                          decoration: InputDecoration(
                              labelText: "Level Separation",
                              labelStyle:
                                  TextStyle(color: AppColor.bgSideMenu)),
                          onChanged: (text) {
                            builder.levelSeparation = int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                          width: AppResponsive.isDesktop(context) ? 10 : 3),
                      Container(
                        width: AppResponsive.isDesktop(context) ? 100 : 50,
                        child: TextFormField(
                          initialValue: builder.subtreeSeparation.toString(),
                          decoration: InputDecoration(
                              labelText: "Subtree separation",
                              labelStyle:
                                  TextStyle(color: AppColor.bgSideMenu)),
                          onChanged: (text) {
                            builder.subtreeSeparation =
                                int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          context
                              .read<NodeProvider>()
                              .createNode(selectedNode, '9999');
                        },
                        child: Text("Add"),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppResponsive.isDesktop(context) ? 50 : 20,
            ),
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 1,
                  maxScale: 1.2,
                  alignPanAxis: true,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id

                      var a = node.key.value as int;
                      String title = _tree
                          .firstWhere((node) => int.parse(node.nodeId) == a)
                          .nodeTitle;

                      return rectangleWidget(a, title);
                    },
                  )),
            )
          ]);
  }

  Widget rectangleWidget(int a, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedNode = a;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: a == selectedNode
              ? BorderRadius.circular(10)
              : BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color:
                    a == selectedNode ? AppColor.yellow : AppColor.bgSideMenu,
                spreadRadius: 1),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
              color: a == selectedNode ? AppColor.bgSideMenu : AppColor.yellow),
        ),
      ),
    );
  }

  Future<void> getTree(String treeId) async {
    await context
        .read<NodeProvider>()
        .getTree(treeId)
        .then((value) => _tree = context.read<NodeProvider>().tree)
        .then((value) => addEdeges())
        .then((value) => _isLeading = false);
  }

  void addEdeges() {
    _tree.forEach((node) {
      if (node.parentId != '-1') {
        graph.addEdge(
            Node.Id(int.parse(node.parentId)), Node.Id(int.parse(node.nodeId)));
      } else
        graph.addNode(Node.Id(int.parse(node.nodeId)));
    });
  }

  @override
  void initState() {
    getTree('1');

    //addEdeges();

    builder
      ..siblingSeparation = (50)
      ..levelSeparation = (50)
      ..subtreeSeparation = (50)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
