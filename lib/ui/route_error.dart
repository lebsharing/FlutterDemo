import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/base_flutter.dart';

class RouteErrorPage extends BaseFlutterPage{
  @override
  State<StatefulWidget> createState() {
    return _RouteErrorPageState();
  }

  @override
  String get tag => "error_route";

}

class _RouteErrorPageState extends BaseFlutterState<RouteErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: Center(
          child: Text(
            "Route create error."
          ),
        ),
      ),
    );
  }

}