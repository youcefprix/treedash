import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/screens/home_page.dart';

import '../common/app_colors.dart';

import 'package:graphview/GraphView.dart';
import '../common/app_responsive.dart';

import 'package:provider/provider.dart';
import '../providers/node_provider.dart';
import '../models/noode.dart';

class TreeDetailsScreen extends StatefulWidget {
  static const String routeName = 'tree_details';

  @override
  _TreeDetailsScreen createState() => _TreeDetailsScreen();
}

class _TreeDetailsScreen extends State<TreeDetailsScreen> {
  Graph graph = Graph()..isTree = true;
  List<Noode> _tree = [];
  bool _isLeading = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  TextEditingController textFcont = TextEditingController();
  int selectedNode;

//Get tree nodes
  Future<void> getTree(String treeId) async {
    await context
        .read<NodeProvider>()
        .getTree(treeId)
        .then((value) => _tree = context.read<NodeProvider>().tree)
        .then((value) => addEdeges())
        .then((value) => _isLeading = false);
  }

//Add edges betwen nodes
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
  void didChangeDependencies() {
    getTree(context.watch<NodeProvider>().treeId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textFcont.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //addEdeges();

    builder
      ..siblingSeparation = (50)
      ..levelSeparation = (50)
      ..subtreeSeparation = (50)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    builder.orientation = 3;
    return Scaffold(
      backgroundColor: AppColor.bgSideMenu,
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: _isLeading
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
                          padding:
                              EdgeInsets.only(left: 20, bottom: 5, right: 20),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    AppResponsive.isDesktop(context) ? 100 : 50,
                                child: TextFormField(
                                  initialValue:
                                      builder.siblingSeparation.toString(),
                                  decoration: InputDecoration(
                                      labelText: "Sibling Separation",
                                      labelStyle: TextStyle(
                                          color: AppColor.bgSideMenu)),
                                  onChanged: (text) {
                                    builder.siblingSeparation =
                                        int.tryParse(text) ?? 100;
                                    this.setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(
                                  width: AppResponsive.isDesktop(context)
                                      ? 10
                                      : 3),
                              Container(
                                width:
                                    AppResponsive.isDesktop(context) ? 100 : 50,
                                child: TextFormField(
                                  initialValue:
                                      builder.levelSeparation.toString(),
                                  decoration: InputDecoration(
                                      labelText: "Level Separation",
                                      labelStyle: TextStyle(
                                          color: AppColor.bgSideMenu)),
                                  onChanged: (text) {
                                    builder.levelSeparation =
                                        int.tryParse(text) ?? 100;
                                    this.setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(
                                  width: AppResponsive.isDesktop(context)
                                      ? 10
                                      : 3),
                              Container(
                                width:
                                    AppResponsive.isDesktop(context) ? 100 : 50,
                                child: TextFormField(
                                  initialValue:
                                      builder.subtreeSeparation.toString(),
                                  decoration: InputDecoration(
                                      labelText: "Subtree separation",
                                      labelStyle: TextStyle(
                                          color: AppColor.bgSideMenu)),
                                  onChanged: (text) {
                                    builder.subtreeSeparation =
                                        int.tryParse(text) ?? 100;
                                    this.setState(() {});
                                  },
                                ),
                              ),
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
                          minScale: 0.8,
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
                                  .firstWhere(
                                      (node) => int.parse(node.nodeId) == a)
                                  .nodeTitle;

                              return rectangleWidget(a, title);
                            },
                          )),
                    )
                  ])),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        backgroundColor: AppColor.yellow,
        onPressed: () {
          Dialog errorDialog = Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            backgroundColor: AppColor.yellow, //this right here
            child: Container(
              padding: EdgeInsets.all(20),
              height: 300.0,
              width: 300.0,
              child: selectedNode == null
                  ? Center(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.error, color: AppColor.bgSideMenu),
                        Text(
                          'Please selecte an element',
                        ),
                      ],
                    ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Add element',
                          style: TextStyle(
                              color: AppColor.bgSideMenu,
                              fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          cursorColor: AppColor.bgSideMenu,
                          controller: textFcont,
                          decoration: InputDecoration(
                              labelText: 'Element title',
                              labelStyle: TextStyle(color: AppColor.bgSideMenu),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.bgSideMenu),
                              )),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'cancel',
                                  style: TextStyle(color: AppColor.bgSideMenu),
                                )),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                if (textFcont.text != '')
                                  context
                                      .read<NodeProvider>()
                                      .createNode(selectedNode, textFcont.text);
                              },
                              child: Text('Add'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.bgSideMenu),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          );
          showDialog(
              context: context, builder: (BuildContext context) => errorDialog);
        },
      ),
    );
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
}
