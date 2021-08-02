import 'package:flutter/material.dart';

import 'package:flutter_hr_management/screens/tree_details_screen.dart';
import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../providers/node_provider.dart';
import 'package:provider/provider.dart';
import '../models/noode.dart';

class RecruitmentDataWidget extends StatefulWidget {
  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  List<Noode> treeList = [];
  TextEditingController textFcont = TextEditingController();
  @override
  void initState() {
    context.read<NodeProvider>().fetchAndSetRoots();
    treeList = context.read<NodeProvider>().roots;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textFcont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.yellow, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      margin: AppResponsive.isDesktop(context)
          ? EdgeInsets.only(left: 150, right: 150, top: 80)
          : EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ََAll the trees",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.yellow,
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Dialog errorDialog = Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      backgroundColor: AppColor.yellow, //this right here
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 300.0,
                        width: 300.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Add a Tree',
                              style: TextStyle(
                                  color: AppColor.bgSideMenu,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              cursorColor: AppColor.bgSideMenu,
                              controller: textFcont,
                              decoration: InputDecoration(
                                  labelText: 'Tree title',
                                  labelStyle:
                                      TextStyle(color: AppColor.bgSideMenu),
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
                                      style:
                                          TextStyle(color: AppColor.bgSideMenu),
                                    )),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    if (textFcont.text != null) {
                                      Navigator.of(context).pop();
                                      context
                                          .read<NodeProvider>()
                                          .createNode(-1, textFcont.text)
                                          .then((value) => context
                                              .read<NodeProvider>()
                                              .fetchAndSetRoots())
                                          .then((value) {
                                        treeList =
                                            context.read<NodeProvider>().roots;
                                      }).then((value) {
                                        setState(() {});
                                      });
                                    }
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
                        context: context,
                        builder: (BuildContext context) => errorDialog);
                  },
                  child: Text('New tree'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.bgSideMenu)),
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          FittedBox(
            fit: BoxFit.cover,
            child: context.read<NodeProvider>().roots.isEmpty
                ? Center(
                    child: Text('No trees to show'),
                  )
                : DataTable(
                    columnSpacing: AppResponsive.isDesktop(context) ? 50 : 10,
                    columns: [
                      DataColumn(label: Text('Select')),
                      DataColumn(
                          label: Container(
                        width: AppResponsive.isDesktop(context)
                            ? 700
                            : AppResponsive.isTablet(context)
                                ? 550
                                : 170,
                        child: Text(
                          'Tree title',
                          maxLines: 2,
                        ),
                      )),
                      DataColumn(label: Text('Edit')),
                      DataColumn(label: Text('Delet')),
                      DataColumn(label: Text('print')),
                    ],
                    rows: [
                      ...context
                          .read<NodeProvider>()
                          .roots
                          .map((node) => tableRow(node))
                          .toList()
                    ],
                  ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Showing ${treeList.length} of Trees"),
              ],
            ),
          )
        ],
      ),
    );
  }

  DataRow tableRow(Noode node) {
    return DataRow(cells: [
      DataCell(
        Checkbox(
          value: false,
          onChanged: (_) {},
        ),
      ),
      DataCell(
        Text(node.nodeTitle),
      ),
      DataCell(
        IconButton(
          icon: Icon(
            Icons.edit_rounded,
            color: AppColor.bgSideMenu,
          ),
          onPressed: () {
            context.read<NodeProvider>().treeId = node.nodeId;
            Navigator.of(context).pushNamed(TreeDetailsScreen.routeName);

            // context.read<NodeProvider>().getTree(node.nodeId);
          },
        ),
      ),
      DataCell(
        IconButton(
          icon: Icon(
            Icons.delete_rounded,
            color: AppColor.bgSideMenu,
          ),
          onPressed: () {
            context.read<NodeProvider>().treeId = node.nodeId;
            context
                .read<NodeProvider>()
                .getTree(context.read<NodeProvider>().treeId)
                .then((value) => context.read<NodeProvider>().deleteTree().then(
                    (value) => context
                            .read<NodeProvider>()
                            .fetchAndSetRoots()
                            .then((value) {
                          setState(() {});
                        })));
          },
        ),
      ),
      DataCell(
        IconButton(
          icon: Icon(
            Icons.print,
            color: AppColor.bgSideMenu,
          ),
          onPressed: () {
            context.read<NodeProvider>().printTree(node.nodeId);
          },
        ),
      ),
    ]);
  }
}
