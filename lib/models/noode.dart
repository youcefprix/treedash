import 'package:flutter/foundation.dart';

class Noode {
  final String nodeId;
  final String parentId;
  final String nodeTitle;

  Noode(
      {@required this.nodeId,
      @required this.parentId,
      @required this.nodeTitle});
}
