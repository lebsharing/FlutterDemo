import 'package:flutter/material.dart';

abstract class BaseFlutterPage extends StatefulWidget implements PageAttribute{
  
}

abstract class BaseFlutterState<T extends BaseFlutterPage> extends State<T> {

}

abstract class PageAttribute {
  final String tag = "base_page";
}