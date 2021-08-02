import 'package:flutter/cupertino.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;

import '../models/noode.dart';

class NodeProvider with ChangeNotifier {
  //API_URL
  final String apiUrl = 'http://localhost/rest_api/api';

  List<Noode> _roots = [];
  List<Noode> _tree = [];
  String treeId;
  List<Noode> get roots => [..._roots];
  List<Noode> get tree => [..._tree];

  Graph graph = Graph()..isTree = true;

  Future<void> fetchAndSetRoots() async {
    var url = Uri.parse('$apiUrl/node/read.php');

    try {
      final response = await http.get(url);

      var extrctedData = json.decode(response.body) as Map<String, dynamic>;
      //extrctedData = extrctedData['trees'];

      List<Noode> loadingRoots = [];
      if (extrctedData['node'] != null)
        extrctedData['node'].forEach((nodeData) {
          loadingRoots.add(Noode(
            nodeId: nodeData['nodeId'],
            parentId: nodeData['parentId'],
            nodeTitle: nodeData['nodeTitle'],
          ));
        });

      _roots = loadingRoots;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //
  void getTreeNodes(List tree) {
    if (tree != null && tree.length > 0) {
      tree.forEach((node) {
        _tree.add(Noode(
            nodeId: '${node['nodeId']}',
            parentId: '${node['parentId']}',
            nodeTitle: '${node['nodeTitle']}'));

        getTreeNodes(node['children']);
      });
      notifyListeners();
    }
  }

//
  Future<void> createNode(int parentId, String nodeTitle) async {
    var url = Uri.parse('$apiUrl/node/create_node.php');

    try {
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'parentId': '$parentId',
          'nodeTitle': nodeTitle,
        }),
      );
    } catch (error) {
      throw error;
    }
  }

//
  Future<void> deleteTree() async {
    var url = Uri.parse('$apiUrl/node/delete.php');
    List<String> listIds = _tree.map((e) => e.nodeId).toList();
    try {
      await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nodeIds': listIds,
        }),
      );
    } catch (error) {
      throw error;
    }
  }

//
  Future<void> getTree(treeId) async {
    _tree = [];
    var url = Uri.parse('$apiUrl/node/read_tree.php?id=$treeId');

    try {
      final response = await http.get(url);

      var treeData = json.decode(response.body);
      //extrctedData = extrctedData['trees'];
      //
      getTreeNodes([treeData]);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

//
  Future<void> printTree(String treeId) async {
    html.AnchorElement anchorElement =
        new html.AnchorElement(href: '$apiUrl/node/print.php?id=$treeId');
    anchorElement.download = '$apiUrl/node/print.php?id=$treeId';
    anchorElement.click();
  }
}
